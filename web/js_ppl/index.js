var url = "index_controller";
var meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
var semanas = ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"];
$(document).ready(function(){
    var fecha = new Date();
    var sfecha = semanas[fecha.getUTCDay()]+", "+fecha.getDate()+" "+meses[fecha.getMonth()]+" "+fecha.getFullYear();
    stop();
    $(".fecha").text(sfecha);
    mas_vistas();
    fotos_menu();
    cargar_portadas();
    cargar_categorias();
});

function mas_vistas() {
    $.post(url, {evento: "mas_vistas"}, function (resp) {
        var json = $.parseJSON(resp); 
        var cuerpo = "";    
        $.each(json,function(i,obj){
            cuerpo+="<li><a href='ver_noticia.jsp?id_noticia="+obj.id+"'>"+obj.titulo+"</a></li>";
        });
        $("#mas_vistas").html(cuerpo);
    });    
}

function fotos_menu() {
        $.post(url, {evento: "fotos_menu"}, function (resp) {
        var json = $.parseJSON(resp);
        $.each(json,function(i,obj){            
            $("#"+obj.descripcion).find("img").each(function(j,obj2){
                if(obj.ultimas_noticias.length>=(j+1)) {
                    $(obj2).attr("src",obj.ultimas_noticias[j].url);
                    $(obj2).parent().next().next().children().children().attr("href","ver_noticia.jsp?id_noticia="+obj.ultimas_noticias[j].id);
                }
            });                        
        });
    });
}
function cargar_portadas() {
    $.post(url, {evento: "portadas"}, function (resp) {
        var json = $.parseJSON(resp);
        var cuerpo = "";
        $.each(json, function (i, obj) {
            var activo = "";
            if (i === 0)
                activo = "active";
            cuerpo += "<div class='item " + activo + "' style='background-image:url(\"" + obj.foto + "\")'> ";
            cuerpo += "<div class='container'>";
            cuerpo += "<div class='row'>";
            cuerpo += "<div class='col-md-7 col-sm-7 col-xs-12 next-post'>";
            cuerpo += "<div class='next-post-wrapper'>";
            cuerpo += "<div>";
            cuerpo += "<p style='margin-left:65%'>" + obj.fecha + "</p>";
            cuerpo += "<p class='slide-cat'>";
            cuerpo += "<a href='#' style='cursor:none;'><span class='cat-icon cat-icon-color02'>" + obj.acronimo + "</span><span>" + obj.categoria + "</span></a>";
            cuerpo += "</p>";
            cuerpo += "<h2 class='slide-title'>";
            cuerpo += "<a href='ver_noticia.jsp?id_noticia="+obj.id+"'>" + obj.titulo + "</a>";
            cuerpo += "</h2>";
            cuerpo += "<br/>";
            cuerpo += "<p>" + obj.subtitulo + "</p>";
            cuerpo += "</div>";
            cuerpo += "</div>";
            cuerpo += "</div>";
            cuerpo += "</div>";
            cuerpo += "</div>";
            cuerpo += "</div>";
        });
        if (json.length > 1)
            $("#car_inner").css("display", "");
        if (json.length > 0)
            $("#portadas").html(cuerpo);
    });
}
function login() {
    var usr = $("input[name=username]").val();
    var pass = $("input[name=password]").val();
    $.post(url, {evento: "login", usr: usr, pass: pass}, function (resp) {
        var json = $.parseJSON(resp);
        if (json.ingresar)
            document.location.href = "index_ppl.html";
        else
            $("#login").modal('hide');
    });
}

function cargar_categorias() {
    $.post(url, {evento: "categorias"}, function (resp) {
        var json = $.parseJSON(resp);
        var cuerpo = "";
        $.each(json, function (i, obj) {
            if(obj.noticias.length>0){
                cuerpo += "<div class='newedge-latest-news default'>";
                cuerpo += "<div class='section-title'>";
                cuerpo += "<h1><span class='cat-icon'><i class='fa fa-bell-o'></i></span>" + obj.descripcion + "</h1>";
                cuerpo += "</div>";
                cuerpo += "<div>";
                cuerpo += armar_slider(obj.noticias);
                cuerpo += armar_normal(obj.noticias);            
                cuerpo += "</div>";
                //cuerpo += "<button onclick='ver_mas("+obj.noticias.id+",this);' data-pagina='1'>mas</button>";
                cuerpo += "</div>";
            }
        });
        $("#cuerpo").html(cuerpo);        
    });
}
function ver_mas(id_categoria,button){
    $.post(url, {evento: "login"}, function (resp) {
        
    });
}
function armar_slider(json) {                  
    var cuerpo = "<div class='row'>";
    var cuerpo_aux="";
    $.each(json,function(i,obj){
        if(i<3){
            if(i===0){
                //<editor-fold desc="el grande">

                    cuerpo += "<div class='col-md-8'>";
                    cuerpo += "<article class='gradient-color04'>";
                    cuerpo += "<div class='article-inner default'>";
                    cuerpo += "<div class='overlay'></div>";
                    cuerpo += "<div class='img-wrapper'><img class='img-100p latest-post-image'  style='height:50%;' src='" + obj.foto + "' alt='img'></div>";
                    //<editor-fold defaultstate="collapsed" desc="SOCIAL">
                    cuerpo += "<div class='post-share-social'>";
					cuerpo +="<a class='fa fa-facebook'  href='javascript: void(0);' onclick=\"window.open('http://www.facebook.com/sharer.php?u=http://kandire.bo/ver_noticia.jsp?id_noticia="+obj.id+"', 'ventanacompartir', toolbar=0, status=0, width=650, height=450);\"></a>";
                    cuerpo += "<a href='#' class='fa fa-twitter'></a>";                    
                    cuerpo += "<div class='share-icon'><i class='fa fa-share-alt'></i></div>";
                    cuerpo += "</div>";
                    //</editor-fold>                        
                    //<editor-fold defaultstate="collapsed" desc="ARTICLE">                                    
                    cuerpo += "<div class='article-info'>";
                    cuerpo += "<p class='slide-cat'>";
                    cuerpo += "<a href='#'>";
                    var su = obj.sub.substring(0,1);
                    cuerpo += "<span class='cat-icon'>"+su+"</span>"+obj.sub
                    cuerpo += "</a>";
                    cuerpo += "</p>";
                    cuerpo += "<h4 class='entry-title'>";
                    cuerpo += "<a href='ver_noticia.jsp?id_noticia="+obj.id+"'>"+obj.titulo+"</a>";
                    cuerpo += "</h4>";
                    cuerpo += "</div>"
                    cuerpo += "<p style='font-family:Times New Roman; text-align: justify; font-size:medium'>";
                    cuerpo += obj.subtitulo;
                    cuerpo += "</p>";
                    cuerpo += "<p><b>fuente :</b><i>"+obj.fuente+"</i> </p>";
                    //</editor-fold>

                    cuerpo += "</div>";
                    cuerpo += "</article>";
                    cuerpo += "</div>";
                    //</editor-fold>
            }else{
                
                //<editor-fold desc="chicos">

                    cuerpo_aux += "<div class='col-md-12'>";
                    cuerpo_aux += "<article class='gradient-color04'>";
                    cuerpo_aux += "<div class='article-inner default'>";
                    cuerpo_aux += "<div class='overlay'></div>";
                    cuerpo_aux += "<div class='img-wrapper'><img class='img-100p latest-post-image'  style='height:150px;' src='" + obj.foto + "' alt='img'></div>";

                    //<editor-fold defaultstate="collapsed" desc="SOCIAL">
                    cuerpo_aux += "<div class='post-share-social'>";
					cuerpo_aux +="<a class='fa fa-facebook'  href='javascript: void(0);' onclick=\"window.open('http://www.facebook.com/sharer.php?u=http://kandire.bo/ver_noticia.jsp?id_noticia="+obj.id+"', 'ventanacompartir', toolbar=0, status=0, width=650, height=450);\"></a>";
                    cuerpo_aux += "<a href='#' class='fa fa-twitter'></a>";
                    cuerpo_aux += "<div class='share-icon'><i class='fa fa-share-alt'></i></div>";
                    cuerpo_aux += "</div>";
                    //</editor-fold>                        
                    //<editor-fold defaultstate="collapsed" desc="ARTICLE">                                    
                    cuerpo_aux += "<div class='article-info'>";
                    cuerpo_aux += "<p class='slide-cat'>";
                    cuerpo_aux += "<a href='#'>";
                    var su = obj.sub.substring(0,1);
                    cuerpo_aux  += "<span class='cat-icon'>"+su+"</span>"+obj.sub
                    cuerpo_aux += "</a>";
                    cuerpo_aux += "</p>";
                    cuerpo_aux += "<h4 class='entry-title'>";
                    cuerpo_aux += "<a href='ver_noticia.jsp?id_noticia="+obj.id+"'>"+obj.titulo+"</a>";
                    cuerpo_aux += "</h4>";
                    cuerpo_aux += "</div>";
                    //</editor-fold>

                    cuerpo_aux += "</div>";
                    cuerpo_aux += "</article>";
                    cuerpo_aux += "</div>";
                    //</editor-fold>
            }
        }else return false;				
    });	
	cuerpo += "<div class='col-md-4'>";	
	cuerpo += cuerpo_aux;
	cuerpo += "</div>";
    
    cuerpo += "</div>";
    return cuerpo;
}
function armar_normal(json) {
    var contenido = "";
    var cuerpo = "";
    var cont = 0;
    $.each(json, function (i, obj) {
        if (i >= 3) {
            contenido += "<div class='col-sm-4'>";
            contenido += "<article class='gradient-color04'>";
            contenido += "<div class='article-inner default'>";
            contenido += "<div class='overlay'></div>";
            contenido += "<div class='img-wrapper'><img class='img-100p latest-post-image'  style='height:150px;' src='" + obj.foto + "' alt='img'></div>";
            //<editor-fold defaultstate="collapsed" desc="SOCIAL">
            contenido += "<div class='post-share-social'>";
	    contenido +="<a class='fa fa-facebook'  href='javascript: void(0);' onclick=\"window.open('http://www.facebook.com/sharer.php?u=http://kandire.bo/ver_noticia.jsp?id_noticia="+obj.id+"', 'ventanacompartir', toolbar=0, status=0, width=650, height=450);\"></a>";
            contenido += "<a href='#' class='fa fa-twitter'></a>";
            contenido += "<div class='share-icon'><i class='fa fa-share-alt'></i></div>";
            contenido += "</div>";
            //</editor-fold>                        
            //<editor-fold defaultstate="collapsed" desc="ARTICLE">                                    
            contenido += "<div class='article-info'>";
            contenido += "<p class='slide-cat'>";
            contenido += "<a href='#'>";
            var su = obj.sub.substring(0,1);
            contenido += "<span class='cat-icon'>"+su+"</span>"+obj.sub
            contenido += "</a>";
            contenido += "</p>";
            contenido += "<h4 class='entry-title'>";
            contenido += "<a href='ver_noticia.jsp?id_noticia="+obj.id+"'>"+obj.titulo+"</a>";
            contenido += "</h4>";
            contenido += "</div>";
            //</editor-fold>

            contenido += "</div>";
            contenido += "</article>";
            contenido += "</div>";
            cont++;
            if (cont === 3) {
                cont = 0;
                cuerpo += "<div class='row'>";
                cuerpo += contenido;
                cuerpo += "</div>";
                contenido = "";
            }
        }
    });
    if (contenido.length > 0) {
        cuerpo += "<div class='row'>";
        cuerpo += contenido;
        cuerpo += "</div>";
    }
    return cuerpo;
}



function cargar_sub_categoria(id_sub, desc) {    
    var acr = desc.substring(0, 1);
    $.post(url, {evento: "cargar_sub_categorias", id: id_sub}, function (resp) {
        var json = $.parseJSON(resp);
        
        var cuerpo = "<div class='newedge-latest-news default'>";
        cuerpo += "<div class='section-title'>";
        cuerpo += "<h1><span class='cat-icon'><i class='fa fa-bell-o'></i></span>" + desc + "</h1>";
        cuerpo += "</div>";
        //cuerpo += armar_slider(obj.noticias);
        cuerpo+=armar_normal(json);            
        cuerpo += "</div>";
                        
        $("#cuerpo").html(cuerpo);
        sessionStorage.setItem("id_sub_car",null);        
        desc=sessionStorage.setItem("desc_sub_car",null);
    });
}