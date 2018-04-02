/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import Conexion.Conexion;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.eventos;
import modelo.noticias;
import modelo.parametros;
import modelo.sub_categoria;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Ruddy
 */
@MultipartConfig
@WebServlet(name = "noticias_controller", urlPatterns = {"/noticias_controller"})
public class noticias_controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
                case "eliminar": html=eliminar(request,response,con); break;
                case "cargar_foto": html=cargar_foto(request,response,con); break;                
                case "cargar_subcategoria": html=cargar_subcategoria(request,response,con); break;                
                case "crear_noticia": html=crear_noticia(request,response,con); break;                
                case "cargar_noticia": html=cargar_noticia(request,response,con); break;                
            }
            con.Close();
            out.write(html);      
        } catch (SQLException ex) {
            Logger.getLogger(noticias_controller.class.getName()).log(Level.SEVERE, null, ex);
            con.Close();
        } catch (JSONException ex) {
            Logger.getLogger(noticias_controller.class.getName()).log(Level.SEVERE, null, ex);
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

    private String cargar(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException {
        String fecha = request.getParameter("fecha");
        JSONObject obj = new JSONObject();
        int id_categoria = Integer.parseInt(request.getParameter("id_categoria"));
        obj.put("noticias", new noticias(con).Todas(fecha, id_categoria));
        //obj.put("subcategorias", new sub_categoria(con).Todas(id_categoria));
        return obj.toString();
    }

    

    private String eliminar(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        return new noticias(con).eliminar(id)+"";
    }

    private String cargar_foto(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, IOException, ServletException {
        int id_noticia = Integer.parseInt(request.getParameter("id_noticia"));
        String desc_foto = request.getParameter("desc_foto");
        String path = new parametros(con).getPathNoticia();
        Part file = request.getPart("file");
        String nombre="";
        if(file!=null){
            nombre = file.getSubmittedFileName();
            nombre=eventos.guardar_file(file, path, nombre);
            new noticias(con).add_foto(id_noticia, desc_foto, nombre,false);
        }
        return true+"";
    }

    private String cargar_subcategoria(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException {
        int id_categoria = Integer.parseInt(request.getParameter("id_categoria"));
        return new sub_categoria(con).Todas(id_categoria).toString();
    }

    private String crear_noticia(HttpServletRequest request, HttpServletResponse response, Conexion con) throws IOException, ServletException, SQLException, JSONException {
        String titulo = request.getParameter("titulo");
        String lugar = request.getParameter("lugar");
        String fecha = request.getParameter("fecha");
        String fuente = request.getParameter("fuente");
        String descripcion = request.getParameter("descripcion");
        String subtitulo = request.getParameter("subtitulo");
        int subcat = Integer.parseInt(request.getParameter("subcat"));
        int id_noticia = Integer.parseInt(request.getParameter("id_noticia"));
        String cb_portada = request.getParameter("cb_portada");
        String url_facebook = request.getParameter("url_facebook");
        String url_you_tube = request.getParameter("url_you_tube");
        boolean is_portada=true;
        if(cb_portada==null) is_portada=false;
        int estado= Integer.parseInt(request.getParameter("estado"));
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        Date dfecha=null;
        try {
            dfecha = formato.parse(fecha);
        } catch (ParseException ex) {
           return false+"";
        }
        
        JSONObject obj = (JSONObject)request.getSession().getAttribute("usr");
        int idusr = obj.getInt("id");
        
        int id=0;
        if(id_noticia>0){
            new noticias(con).modificar(id_noticia,titulo, subtitulo, dfecha, descripcion, lugar, fuente, subcat,estado,is_portada, url_facebook, url_you_tube);
            id=id_noticia;
        }
        else id = new noticias(con).insertar(titulo, subtitulo, dfecha, descripcion, lugar, fuente, subcat,estado,is_portada, url_facebook, url_you_tube,idusr);
        String path = getServletContext().getRealPath("/");
        //path=path.substring(0,path.length()-1);
        path+="/img/noticias/";
        Part foto1 = request.getPart("foto1");
        int id_foto1 = Integer.parseInt(request.getParameter("id_foto1"));
        String desc_foto1 = request.getParameter("desc_foto1");            
        if(id_foto1>0)  new noticias(con).update_foto_desc(id_foto1, desc_foto1);
        if(foto1!=null)
        {            
            String nombre = foto1.getSubmittedFileName();
            if(nombre.length()>2){  
                String foto[] = nombre.split(Pattern.quote("."));
                String ext = foto[foto.length-1];
                nombre = "foto"+id+"."+ext;
                nombre = eventos.guardar_file(foto1, path, nombre);
                //int id_foto1 = Integer.parseInt(request.getParameter("id_foto1"));
                if(id_foto1==0) new noticias(con).add_foto(id, desc_foto1, nombre,true);
                else new noticias(con).update_foto(id_foto1, desc_foto1, nombre,true);
            }
        }
                
        return true+"";
    }

    private String cargar_noticia(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        return new noticias(con).buscar(id).toString();
    }

}
