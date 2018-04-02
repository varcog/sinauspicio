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

public class noticias {
    
    private int id;
    private String titulo;
    private String subtitulo;
    private String descripcion;
    private String lugar;
    private String fecha;
    private String fuente;
    private String url_facebook;
    private String url_you_tube;
    private int id_sub_categoria;
    private int vistos;
    private boolean estado;
    private boolean is_portada;
    private Conexion con;

    public noticias(Conexion con) {
        this.con = con;
    }

    public noticias(int id, String titulo, String subtitulo, String descripcion, String lugar, String fecha, String fuente, int id_sub_categoria, int vistos, boolean estado, boolean is_portada) {
        this.id = id;
        this.titulo = titulo;
        this.subtitulo = subtitulo;
        this.descripcion = descripcion;
        this.lugar = lugar;
        this.fecha = fecha;
        this.fuente = fuente;
        this.id_sub_categoria = id_sub_categoria;
        this.vistos = vistos;
        this.estado = estado;
        this.is_portada = is_portada;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getSubtitulo() {
        return subtitulo;
    }

    public void setSubtitulo(String subtitulo) {
        this.subtitulo = subtitulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getFuente() {
        return fuente;
    }

    public void setFuente(String fuente) {
        this.fuente = fuente;
    }

    public int getId_sub_categoria() {
        return id_sub_categoria;
    }

    public void setId_sub_categoria(int id_sub_categoria) {
        this.id_sub_categoria = id_sub_categoria;
    }

    public int getVistos() {
        return vistos;
    }

    public void setVistos(int vistos) {
        this.vistos = vistos;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public Conexion getCon() {
        return con;
    }

    public void setCon(Conexion con) {
        this.con = con;
    }

    public boolean isIs_portada() {
        return is_portada;
    }

    public void setIs_portada(boolean is_portada) {
        this.is_portada = is_portada;
    }
    
    
    
    public int insertar(String titulo, String subtitulo, Date fecha, String descripcion, String lugar, String fuente, int sub, int estado, boolean is_portada, String url_facebook, String url_youtube, int id_usuario) throws SQLException{
        java.sql.Date sql = new java.sql.Date(fecha.getTime());
        String consulta = "insert into noticias (titulo, subtitulo, fecha, descripcion, lugar , fuente, estado, vistos, id_sub_categoria,is_portada, url_facebook, url_you_tube, id_usuario) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = con.statamet(consulta);
        ps.setString(1, titulo);
        ps.setString(2, subtitulo);
        ps.setDate(3, sql);
        ps.setString(4, descripcion);
        ps.setString(5, lugar);
        ps.setString(6, fuente);
        if(estado==1) ps.setBoolean(7, true);
        else ps.setBoolean(7, false);
        ps.setInt(8, 0);
        ps.setInt(9, sub);
        ps.setBoolean(10, is_portada);
        ps.setString(11, url_facebook);
        ps.setString(12, url_youtube);
        ps.setInt(13, id_usuario);
        ps.execute();
        consulta="select last_value as id from noticias_id_seq";
        ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        int id=0;
        if(rs.next()) id=rs.getInt("id");
        ps.close();
        rs.close();
        return id;
    }
    public boolean modificar(int id, String titulo, String subtitulo, Date fecha, String descripcion, String lugar, String fuente, int sub, int estado, boolean is_portada, String url_facebook, String url_you_tube) throws SQLException{
        java.sql.Date sql = new java.sql.Date(fecha.getTime());
        String consulta = "update noticias set titulo=?, subtitulo=?, fecha=?, descripcion=?, lugar=?, fuente=?, estado=?, vistos=?, id_sub_categoria=?, is_portada=?, url_facebook=?, url_you_tube=? where id="+id;
        PreparedStatement ps = con.statamet(consulta);
        ps.setString(1, titulo);
        ps.setString(2, subtitulo);
        ps.setDate(3, sql);
        ps.setString(4, descripcion);
        ps.setString(5, lugar);
        ps.setString(6, fuente);
        if(estado==1) ps.setBoolean(7, true);
        else ps.setBoolean(7, false);
        ps.setInt(8, 0);
        ps.setInt(9, sub);
        ps.setBoolean(10, is_portada);        
        ps.setString(11, url_facebook);        
        ps.setString(12, url_you_tube);        
        ps.execute();        
        ps.close();        
        return true;
    }
    
    public JSONArray Todas(String fecha, int id_categoria) throws SQLException, JSONException{
        String consulta = "select noticias.id,\n"
                + "noticias.titulo,\n"
                + "noticias.subtitulo,\n"
                + "noticias.descripcion,\n"
                + "noticias.lugar,\n"
                + "to_char(noticias.fecha,'DD/MM/YYYY') as fecha,\n"
                + "noticias.fuente,\n"
                + "noticias.estado,\n"
                + "noticias.vistos,\n"
                + "sub_categoria.descripcion as subcategoria\n"
                + "from noticias, sub_categoria, categoria\n"
                + "where to_char(fecha,'DD/MM/YYYY') = '"+fecha+"' \n"
                + "and noticias.id_sub_categoria = sub_categoria.id\n"
                + "and categoria.id = "+id_categoria+"\n"
                + "and sub_categoria.id_categoria = categoria.id";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("titulo", rs.getString("titulo"));
            obj.put("subtitulo", rs.getString("subtitulo"));
            obj.put("descripcion", rs.getString("descripcion"));
            obj.put("subcategoria", rs.getString("subcategoria"));
            obj.put("lugar", rs.getString("lugar"));
            obj.put("fecha", rs.getString("fecha"));
            obj.put("fuente", rs.getString("fuente"));            
            obj.put("vistos", rs.getInt("vistos"));
            obj.put("estado", rs.getBoolean("estado"));            
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }

    
    
    public boolean add_foto(int id_noticia, String desc, String nombre, boolean is_portada) throws SQLException{        
        String consulta = "insert into noticia_fotos (id_noticia, descripcion, nombre, is_portada) values (?,?,?,?)";
        PreparedStatement ps = con.statamet(consulta);
        ps.setInt(1, id_noticia);
        ps.setString(2, desc);
        ps.setString(3, nombre);
        ps.setBoolean(4, is_portada);       
        ps.execute();
        return true;
    }
    public boolean update_foto(int id, String desc, String nombre, boolean is_portada) throws SQLException{        
        String consulta = "update noticia_fotos set descripcion=?, nombre=?, is_portada=? where id="+id;
        PreparedStatement ps = con.statamet(consulta);        
        ps.setString(1, desc);
        ps.setString(2, nombre);
        ps.setBoolean(3, is_portada);       
        ps.execute();
        return true;
    }
    public boolean update_foto_desc(int id, String desc) throws SQLException{        
        String consulta = "update noticia_fotos set descripcion=? where id="+id;
        PreparedStatement ps = con.statamet(consulta);        
        ps.setString(1, desc);        
        ps.execute();
        return true;
    }
    public boolean eliminar_fotos(int id_noticia) throws SQLException{
        String consulta = "delete from noticia_fotos where id_noticia="+id;
        con.EjecutarSentencia(consulta);
        return true;
    }
    public boolean eliminar(int id) throws SQLException {
        String consulta = "delete from noticia_fotos where id_noticia="+id;
        con.EjecutarSentencia(consulta);
        consulta = "delete from noticias where id="+id;
        con.EjecutarSentencia(consulta);
        return true;
    }
    public JSONArray ToasXcategoria() throws SQLException, IOException, JSONException{
        String consulta = "select * from categoria order by id";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("descripcion", rs.getString("descripcion"));            
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("noticias", TodasHoyConFotoxCategoria(rs.getInt("id")));
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
    public JSONArray TodasHoyConFotoxCategoria(int id_categoria) throws SQLException, JSONException, IOException{
        
        String consulta = "select noticias.titulo, \n" +
                            "noticias.id,\n" +
                            "categoria.acronimo,\n" +
                            "categoria.descripcion,\n" +
                            "sub_categoria.descripcion sub,\n" +
                            "noticias.subtitulo,\n" +
                            "noticias.fuente,\n" +
                            "max(noticia_fotos.nombre) AS nombre\n" +
                            "from noticias,\n" +
                            "sub_categoria,\n" +
                            "categoria,\n" +
                            "noticia_fotos\n" +
                            "where sub_categoria.id = noticias.id_sub_categoria\n" +
                            "and categoria.id = sub_categoria.id_categoria\n" +
                            "and noticia_fotos.id_noticia = noticias.id\n" +
                            "and categoria.id  = "+id_categoria+"\n" +
                            "group by noticias.titulo,sub_categoria.descripcion, \n" +
                            "categoria.acronimo,noticias.subtitulo,noticias.fuente,noticias.id, categoria.descripcion order by noticias.id desc limit 9\n";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        String path = new parametros(con).getPathNoticia();
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("titulo", rs.getString("titulo"));
            obj.put("subtitulo", rs.getString("subtitulo"));
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("descripcion", rs.getString("descripcion")); 
            obj.put("sub", rs.getString("sub")); 
            obj.put("fuente", rs.getString("fuente")); 
            obj.put("foto", eventos.obtener_file(path, rs.getString("nombre")));             
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
    public JSONArray TodasHoyConFotoxSubCategoria(int id_sub,int page) throws SQLException, JSONException, IOException{
        int fin = page*3;
        int ini = fin -3;
        String consulta = "select noticias.titulo, \n" +
                            "noticias.id,\n" +
                            "categoria.acronimo,\n" +
                            "categoria.descripcion,\n" +
                            "max(noticia_fotos.nombre) AS nombre\n" +
                            "from noticias,\n" +
                            "sub_categoria,\n" +
                            "categoria,\n" +
                            "noticia_fotos\n" +
                            "where categoria.id = sub_categoria.id_categoria\n" +
                            "and noticia_fotos.id_noticia = noticias.id\n" +
                            "and sub_categoria.id  = "+id_sub+"\n" +
                            "group by noticias.titulo, \n" +
                            "categoria.acronimo,noticias.id,categoria.descripcion";
                            //"categoria.descripcion limit "+fin+" offset "+ini;
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        String path = new parametros(con).getPathNoticia();
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("titulo", rs.getString("titulo"));
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("descripcion", rs.getString("descripcion")); 
            obj.put("foto", eventos.obtener_file(path, rs.getString("nombre")));             
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
        
    public JSONArray TodasHoyPortada() throws SQLException, JSONException, IOException{
        
        String consulta = "select noticias.id,noticias.titulo, \n" +
                            "to_char(noticias.fecha,'DD/MM/YYYY') AS fecha,\n" +
                            "noticias.subtitulo,\n" +
                            "categoria.acronimo,\n" +
                            "categoria.descripcion,\n" +
                            "max(noticia_fotos.nombre) AS nombre\n" +
                            "from noticias,\n" +
                            "sub_categoria,\n" +
                            "categoria,\n" +
                            "noticia_fotos\n" +
                            "where noticias.is_portada = true\n" +
                            "and sub_categoria.id = noticias.id_sub_categoria\n" +
                            "and categoria.id = sub_categoria.id_categoria\n" +
                            "and noticia_fotos.id_noticia = noticias.id\n" +                            
                            "group by noticias.titulo, \n" +
                            "categoria.acronimo, categoria.descripcion,noticias.fecha,noticias.subtitulo,noticias.id order by noticias.id desc limit 5 ";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        String path = new parametros(con).getPathNoticia();
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("titulo", rs.getString("titulo"));
            obj.put("subtitulo", rs.getString("subtitulo"));
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("categoria", rs.getString("descripcion")); 
            obj.put("fecha", rs.getString("fecha")); 
            obj.put("foto", eventos.obtener_file(path, rs.getString("nombre")));             
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }

    public JSONObject buscar(int id) throws SQLException, JSONException, IOException {
        String consulta = "select noticias.*, "
                + "sub_categoria.descripcion as subcat, "
                + "categoria.descripcion as categoria, "
                + "categoria.acronimo as acronimo "
                + "from noticias, "
                + "sub_categoria, "
                + "categoria "
                + "where noticias.id="+id+" "
                + "and sub_categoria.id = noticias.id_sub_categoria "
                + "and categoria.id = sub_categoria.id_categoria";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        JSONObject obj = new JSONObject();
        if (rs.next()) {            
            obj.put("id", rs.getInt("id"));
            obj.put("titulo", rs.getString("titulo"));            
            obj.put("subtitulo", rs.getString("subtitulo"));            
            obj.put("descripcion", rs.getString("descripcion"));            
            obj.put("categoria", rs.getString("categoria"));            
            obj.put("subcat", rs.getString("subcat"));            
            obj.put("acronimo", rs.getString("acronimo"));            
            obj.put("lugar", rs.getString("lugar"));            
            obj.put("fecha", formato.format(rs.getDate("fecha")));            
            obj.put("fuente", rs.getString("fuente"));            
            obj.put("url_facebook", rs.getString("url_facebook"));            
            obj.put("url_you_tube", rs.getString("url_you_tube"));            
            obj.put("id_sub_categoria", rs.getInt("id_sub_categoria"));
            obj.put("vistos", rs.getInt("vistos"));
            obj.put("estado", rs.getBoolean("estado"));                             
            obj.put("fotos", fotos(rs.getInt("id")));            
            obj.put("is_portada", rs.getBoolean("is_portada"));            
        }
        ps.close();
        rs.close();
        return obj;
    }
    
    public  void suma_vistos(int id_noticia) throws SQLException{
        String consulta ="update noticias set vistos = \n" +
                        "(select vistos+1\n" +
                        "from noticias\n" +
                        "where id ="+id_noticia+")\n" +
                        "where id = "+id_noticia;
        con.EjecutarSentencia(consulta);
    }
    
    
    public JSONArray fotos(int id) throws SQLException, JSONException, JSONException, IOException{
        String path = new parametros(con).getPathNoticia();
        String consulta = "select * from noticia_fotos where id_noticia="+id+" order by id";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("descripcion", rs.getString("descripcion"));            
            obj.put("is_portada", rs.getBoolean("is_portada"));            
            obj.put("foto", eventos.obtener_file(path, rs.getString("nombre")));            
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }

    public JSONArray mas_vistas() throws SQLException, JSONException {
        String consulta = "select id, titulo from noticias order by vistos desc limit 10 offset 0";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        JSONArray json = new JSONArray();
        JSONObject obj;
        while (rs.next()) {
            obj = new JSONObject();
            obj.put("id", rs.getInt("id"));
            obj.put("titulo", rs.getString("titulo"));            
            json.put(obj);
        }
        ps.close();
        rs.close();
        return json;
    }
    
}
