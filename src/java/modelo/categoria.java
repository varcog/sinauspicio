/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import Conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Ruddy
 */
public class categoria {
    private int id;
    private String descripcion;
    private String acronimo;
    private Conexion con;

    public categoria(Conexion con) {
        this.con = con;
    }
    
    

    public categoria(int id, String descripcion, String acronimo) {
        this.id = id;
        this.descripcion = descripcion;
        this.acronimo = acronimo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getAcronimo() {
        return acronimo;
    }

    public void setAcronimo(String acronimo) {
        this.acronimo = acronimo;
    }

    public Conexion getCon() {
        return con;
    }

    public void setCon(Conexion con) {
        this.con = con;
    }

    public JSONArray Todas() throws SQLException, JSONException {
        String consulta ="select * from categoria";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while(rs.next()){
            obj=new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("descripcion", rs.getString("descripcion"));            
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("icon", rs.getString("icon"));            
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
    public JSONArray menu() throws SQLException, JSONException {
        String consulta ="select * from categoria order by id";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while(rs.next()){
            obj=new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("descripcion", rs.getString("descripcion"));            
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("sub_categoria", new sub_categoria(con).Todas(rs.getInt("id")));            
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
    
    
}
