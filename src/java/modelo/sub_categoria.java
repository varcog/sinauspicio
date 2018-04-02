package modelo;

import Conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Ruddy
 */
public class sub_categoria {

    private int id;
    private int descripcion;
    private int id_categoria;
    private Conexion con;

    public sub_categoria(Conexion con) {
        this.con = con;
    }

    public sub_categoria(int id, int descripcion, int id_categoria) {
        this.id = id;
        this.descripcion = descripcion;
        this.id_categoria = id_categoria;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(int descripcion) {
        this.descripcion = descripcion;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public Conexion getCon() {
        return con;
    }

    public void setCon(Conexion con) {
        this.con = con;
    }

    public JSONArray Todas(int id_categoria) throws SQLException, JSONException {
        String consulta = "select * from sub_categoria where id_categoria=" + id_categoria;
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("descripcion", rs.getString("descripcion"));
            obj.put("id_categoria", rs.getInt("id_categoria"));
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }

    public JSONArray Todas_fotos_ultimas_noticias() throws SQLException, JSONException {
        String consulta = "select * from sub_categoria";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("descripcion", rs.getString("descripcion"));
            obj.put("ultimas_noticias", ultimas_noticias(rs.getInt("id")));
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
    
    private JSONArray ultimas_noticias(int id_sub) throws SQLException, JSONException{
        String consulta = "select noticias.id as id_noticia,max(noticia_fotos.id), noticia_fotos.nombre \n" +
                            "from noticias, noticia_fotos\n" +
                            "where id_sub_categoria = "+id_sub+"\n" +
                            "and noticia_fotos.id_noticia = noticias.id\n" +
                            "group by noticia_fotos.nombre, noticias.id\n" +
                            "order by noticias.id desc\n" +
                            "limit 3";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();            
            obj.put("url", "img/noticias/"+rs.getString("nombre"));            
            obj.put("id", rs.getInt("id_noticia"));            
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
}
