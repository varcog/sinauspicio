/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.categoria;
import modelo.noticias;
import modelo.publicidad;
import modelo.sub_categoria;
import modelo.usuario;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author equipo_2
 */
@WebServlet(name = "index_controller", urlPatterns = {"/index_controller"})
public class index_controller extends HttpServlet {

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
                case "mas_vistas": html=mas_vistas(request,response,con); break;                
                case "publicidad": html=publicidad(request,response,con); break;                
                case "login": html=login(request,response,con); break;                
                case "cargar": html=cargar(request,response,con); break;
                case "portadas": html=portadas(request,response,con); break;
                case "categorias": html=categorias(request,response,con); break;
                case "cargar_sub_categorias": html=cargar_sub_categorias(request,response,con); break;
                case "fotos_menu": html=fotos_menu(request,response,con); break;
            }
            con.Close();            
            out.write(html);       
        } catch (JSONException ex) {
            Logger.getLogger(index_controller.class.getName()).log(Level.SEVERE, null, ex);
            con.Close();
        } catch (SQLException ex) {
            Logger.getLogger(index_controller.class.getName()).log(Level.SEVERE, null, ex);
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

    private String login(HttpServletRequest request, HttpServletResponse response, Conexion con) throws JSONException, SQLException {        
        String usr = request.getParameter("usr");
        String pass = request.getParameter("pass");
        JSONObject obj = new usuario(con).login(usr, pass);
        request.getSession().setAttribute("usr", obj);
        return obj.toString();
    }

    private String cargar(HttpServletRequest request, HttpServletResponse response, Conexion con) throws JSONException, SQLException, IOException {        
        return new categoria(con).menu().toString();
    }

    private String portadas(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException, IOException {
        return new noticias(con).TodasHoyPortada().toString();
    }

    private String categorias(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, IOException, JSONException {
        return new noticias(con).ToasXcategoria().toString();
    }

    private String publicidad(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, IOException {
        return new publicidad(con).getImagen();
    }

    private String cargar_sub_categorias(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        return new noticias(con).TodasHoyConFotoxSubCategoria(id,0).toString();
    }

    private String mas_vistas(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException {
        return new noticias(con).mas_vistas().toString();
    }

    private String fotos_menu(HttpServletRequest request, HttpServletResponse response, Conexion con) throws SQLException, JSONException {
        return new sub_categoria(con).Todas_fotos_ultimas_noticias().toString();
    }

}
