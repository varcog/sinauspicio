package modelo;

import Conexion.Conexion;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class publicidad {
    
    private int id;
    private String url_imagen;
    private boolean estado;
    private Date fecha_expiracion;
    private double porcentage;
    private Conexion con;

    public publicidad(Conexion con) {
        this.con = con;
    }

    public publicidad(int id, String url_imagen, boolean estado, Date fecha_expiracion, double porcentage) {
        this.id = id;
        this.url_imagen = url_imagen;
        this.estado = estado;
        this.fecha_expiracion = fecha_expiracion;
        this.porcentage = porcentage;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUrl_imagen() {
        return url_imagen;
    }

    public void setUrl_imagen(String url_imagen) {
        this.url_imagen = url_imagen;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public Date getFecha_expiracion() {
        return fecha_expiracion;
    }

    public void setFecha_expiracion(Date fecha_expiracion) {
        this.fecha_expiracion = fecha_expiracion;
    }

    public double getPorcentage() {
        return porcentage;
    }

    public void setPorcentage(double porcentage) {
        this.porcentage = porcentage;
    }

    public Conexion getCon() {
        return con;
    }

    public void setCon(Conexion con) {
        this.con = con;
    }
    
    public JSONArray todas() throws JSONException, SQLException, IOException{
        String consulta = "SELECT id, url_imagen, estado, to_char(fecha_expiracion,'DD/MM/YYYY') as fecha_expiracion, porcentaje, descripcion\n" +
                          " FROM public.publicidad;";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        String path = new parametros(con).getPathPublicidad();
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("url_imagen", rs.getString("url_imagen"));
            obj.put("foto", eventos.obtener_file(path, rs.getString("url_imagen")));
            obj.put("estado", rs.getBoolean("estado"));
            obj.put("fecha_expiracion", rs.getString("fecha_expiracion"));
            obj.put("porcentaje", rs.getDouble("porcentaje"));
            obj.put("descripcion", rs.getString("descripcion"));
            json.put(obj);
        }        
        ps.close();
        rs.close();
        return json;
    }

    public JSONObject insertar() throws SQLException, JSONException, IOException {
        String consulta = "INSERT INTO public.publicidad(\n" +
                            "	 url_imagen, estado, fecha_expiracion, porcentaje, descripcion)\n" +
                            "	VALUES (?, ?, ?, ?, ?);";
        PreparedStatement ps = con.statamet(consulta);
        ps.setString(1, "");
        ps.setBoolean(2, false);
        java.sql.Date date = new java.sql.Date(new Date().getTime());
        ps.setDate(3,date);
        ps.setDouble(4, 0);
        ps.setString(5, "");
        ps.execute();
        consulta="select last_value as id from publicidad_id_seq";
        ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        int id =0;
        if(rs.next())id=rs.getInt("id");
        JSONObject obj = buscar(id);
        ps.close();
        rs.close();
        return obj;
    }
    
    public JSONObject buscar(int id) throws SQLException, JSONException, IOException{
        String consulta = "SELECT id, url_imagen, estado, to_char(fecha_expiracion,'DD/MM/YYYY') as fecha_expiracion, porcentaje, descripcion\n" +
                        "	FROM public.publicidad where id="+id;
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();        
        JSONObject obj = new JSONObject();
        String path = new parametros(con).getPathPublicidad();
        while (rs.next()) {            
            obj.put("id", rs.getInt("id"));
            obj.put("url_imagen", rs.getString("url_imagen"));
            obj.put("foto", eventos.obtener_file(path, rs.getString("url_imagen")));
            obj.put("estado", rs.getBoolean("estado"));
            obj.put("fecha_expiracion", rs.getString("fecha_expiracion"));
            obj.put("porcentaje", rs.getDouble("porcentaje"));
            obj.put("descripcion", rs.getString("descripcion"));            
        }    
        ps.close();
        rs.close();
        return obj;
    }

    public void update(int id, String desc, boolean estado, Date fecha, double porc) throws SQLException {
        String consulta = "UPDATE public.publicidad\n" +
                        "	SET estado=?, fecha_expiracion=?, porcentaje=?, descripcion=?\n" +
                        "	WHERE id="+id;
        PreparedStatement ps = con.statamet(consulta);
        ps.setBoolean(1, estado);
        java.sql.Date fechaa = new java.sql.Date(fecha.getTime());
        ps.setDate(2, fechaa);
        ps.setDouble(3, porc);
        ps.setString(4, desc);
        ps.execute();        
    }
    public void update(int id, String url_imagen) throws SQLException {
        String consulta = "UPDATE public.publicidad\n" +
                        "	SET url_imagen=?\n" +
                        "	WHERE id="+id;
        PreparedStatement ps = con.statamet(consulta);
        ps.setString(1, url_imagen);        
        ps.execute();        
    }

    public String getImagen() throws SQLException, IOException {
        String consulta = "SELECT url_imagen \n" +
                          "FROM publicidad where estado=true ORDER BY random() LIMIT 1";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        String foto="";
        if (rs.next()) {
            String path = new parametros(con).getPathPublicidad();
            foto=eventos.obtener_file(path,rs.getString("url_imagen"));
        }        
        ps.close();
        rs.close();
        return foto;
    }
    
}
