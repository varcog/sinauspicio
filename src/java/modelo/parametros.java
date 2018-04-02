package modelo;

import Conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class parametros {
    private int ID;
    private String NOMBRE;
    private String PARAM;
    private Conexion con;

    public parametros(Conexion con) {
        this.con = con;
    }

    public parametros(int ID, String NOMBRE, String PARAM) {
        this.ID = ID;
        this.NOMBRE = NOMBRE;
        this.PARAM = PARAM;
    }
    
    public void insertar() throws SQLException{
        String consulta = "";
        con.EjecutarSentencia(consulta);
    }
    public void eliminar() throws SQLException{
        String consulta = "";
        con.EjecutarSentencia(consulta);
    }
    public void modificar() throws SQLException{
        String consulta = "";
        con.EjecutarSentencia(consulta);
    }
    
    public String getPathPublicidad() throws SQLException{
        String consulta ="SELECT parametros.param FROM public.parametros WHERE ID=1";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        String path = "";
        if(rs.next()) path=rs.getString("param");
        rs.close();
        ps.close();
        return path;
    }
    public String getPathNoticia() throws SQLException{
        String consulta ="SELECT parametros.param FROM public.parametros WHERE ID=2";
        PreparedStatement ps = con.statamet(consulta);
        ResultSet rs = ps.executeQuery();
        String path = "";
        if(rs.next()) path=rs.getString("param");
        rs.close();
        ps.close();
        return path;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNOMBRE() {
        return NOMBRE;
    }

    public void setNOMBRE(String NOMBRE) {
        this.NOMBRE = NOMBRE;
    }

    public String getPARAM() {
        return PARAM;
    }

    public void setPARAM(String PARAM) {
        this.PARAM = PARAM;
    }

    public Conexion getCon() {
        return con;
    }

    public void setCon(Conexion con) {
        this.con = con;
    }
    
    
    
}
