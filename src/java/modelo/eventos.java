/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Iterator;
import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.Part;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author RICKY
 */
public class eventos {

    public static String guardar_file(Part file, String url, String nombre) throws IOException {
        int dbs = 2048;
        File d = new File(url);
        if (!d.exists()) {
            d.mkdirs();
        }
        File f = new File(url + nombre);
        int contador = 0;
        while (f.exists()) {
            contador++;
            nombre = contador + nombre;
            f = new File(url + nombre);
        }
        InputStream in = null;
        OutputStream out = null;

        try {
            in = new BufferedInputStream(file.getInputStream(), dbs);
            out = new BufferedOutputStream(new FileOutputStream(f), dbs);
            byte[] bufer = new byte[dbs];
            for (int i = 0; ((i = in.read(bufer)) > 0);) {
                out.write(bufer, 0, i);
            }
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException ex) {
                    System.out.println(ex);
                }
                try {
                    in.close();
                } catch (IOException ex) {
                    System.out.println(ex);
                }   
            }
        }
        return nombre;
    }

    private void comprimir(File file) throws IOException {
        
        BufferedImage image = ImageIO.read(file);

        File compressedImageFile = new File("compreed_"+file.getName());
        OutputStream os = new FileOutputStream(compressedImageFile);

        Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");
        ImageWriter writer = (ImageWriter) writers.next();

        ImageOutputStream ios = ImageIO.createImageOutputStream(os);
        writer.setOutput(ios);

        ImageWriteParam param = writer.getDefaultWriteParam();

        param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
        param.setCompressionQuality(0.05f);
        writer.write(null, new IIOImage(image, null, null), param);
        os.close();
        ios.close();
        writer.dispose();
    }

    /*public static String obtener_file(String url, String nombre) throws IOException {
        if(nombre.length()>2){
            File file = new File(url + nombre);
            String encodedBase64 = null;
            try {
                FileInputStream fileInputStreamReader = new FileInputStream(file);
                byte[] bytes = new byte[(int) file.length()];
                fileInputStreamReader.read(bytes);
                encodedBase64 = new String(Base64.encodeBase64(bytes));
            } catch (Exception e) {
                System.out.println(e);
            }

            return "data:image/png;base64," + encodedBase64;
        }else{
            return "img/vacia.jpg";
        }
    }*/
    public static String obtener_file(String url, String nombre) throws IOException {
       return "img/noticias/"+nombre;
    }
}
