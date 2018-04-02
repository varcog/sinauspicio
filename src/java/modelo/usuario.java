package modelo;

import Conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONException;
import org.json.JSONObject;

public class usuario {
    private int id;
    private String usr;
    private String pass;
    private boolean estado;
    private int tipo;
    private String nombre;
    private Conexion con;

    public usuario(Conexion con) {
        this.con = con;
    }

    public usuario(int id, String usr, String pass, boolean estado, int tipo, String nombre) {
        this.id = id;
        this.usr = usr;
        this.pass = pass;
        this.estado = estado;
        this.tipo = tipo;
        this.nombre = nombre;
    }   
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsr() {
        return usr;
    }

    public void setUsr(String usr) {
        this.usr = usr;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Conexion getCon() {
        return con;
    }

    public void setCon(Conexion con) {
        this.con = con;
    }
    
    public JSONObject login(String usr, String pass) throws SQLException, JSONException{
        String consulta = "select * from usuario where usr=? and pass=?";
        PreparedStatement ps = con.statamet(consulta);
        ps.setString(1, usr);
        ps.setString(2, pass);
        ResultSet rs = ps.executeQuery();
        JSONObject obj = new JSONObject();
        if (rs.next()) {
            obj.put("id", rs.getInt("id"));
            obj.put("usr", rs.getString("usr"));
            obj.put("nombre", rs.getString("nombre"));
            obj.put("pass", rs.getString("pass"));
            obj.put("estado", rs.getBoolean("estado"));
            obj.put("tipo", rs.getInt("tipo"));
            obj.put("ingresar", true);            
        }        
        ps.close();
        rs.close();
        return obj;
    }
    
}
