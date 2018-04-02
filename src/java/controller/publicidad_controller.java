package controller;

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.eventos;
import modelo.parametros;
import modelo.publicidad;
import org.json.JSONException;

/**
 *
 * @author Ruddy
 */
@MultipartConfig
@WebServlet(name = "publicidad_controller", urlPatterns = {"/publicidad_controller"})
public class publicidad_controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Conexion con = new Conexion();
        try (PrintWriter out = response.getWriter()) {
            String html = "";
            String evento = request.getParameter("evento");
            switch(evento){                
                case "cargar": html=cargar(request,response,con); break;                
                case "nueva_publicidad": html=nueva_publicidad(request,response,con); break;                
                case "modificar": html=modificar(request,response,con); break;                
                case "upload_baner": html=upload_baner(request,response,con); break;                
            }
            con.Close();
            out.write(html);      
        } catch (SQLException ex) {
            Logger.getLogger(publicidad_controller.class.getName()).log(Level.SEVERE, null, ex);
            con.Close();
        } catch (JSONException ex) {
            Logger.getLogger(publicidad_controller.class.getName()).log(Level.SEVERE, null, ex);
            con.Close();
        } catch (ParseException ex) {
            Logger.getLogger(publicidad_controller.class.getName()).log(Level.SEVERE, null, ex);
            con.Close();
        } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String cargar(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException, IOException {     
        return new publicidad(con).todas().toString();
    }       

    private String nueva_publicidad(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException, IOException {
        return new publicidad(con).insertar().toString();
    }

    private String modificar(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, ParseException {
        int id = Integer.parseInt(request.getParameter("id"));
        String desc = request.getParameter("desc");
        boolean estado= Boolean.parseBoolean(request.getParameter("estado"));
        String fecha= request.getParameter("fecha");
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        double porc= Double.parseDouble(request.getParameter("porc"));
        Date dfecha=new Date();
        try{
            dfecha=formato.parse(fecha);
        }catch(ParseException e){}
        new publicidad(con).update(id,desc,estado,dfecha,porc);
        return true+"";
    }

    private String upload_baner(HttpServletRequest request, HttpServletResponse response, Conexion con) throws IOException, ServletException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Part file = request.getPart("file");
        String nombre="";
        if(file!=null){
            nombre = file.getSubmittedFileName();
            if(nombre.length()>2){
                String path = new parametros(con).getPathPublicidad();
                nombre=eventos.guardar_file(file, path, nombre);
                new publicidad(con).update(id, nombre);
            }
        }
        return true+"";
    }
}
