var url = "ver_noticia_controller";
var meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
var semanas = ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"];
$(document).ready(function () {
    var fecha = new Date();
    var sfecha = semanas[fecha.getUTCDay()]+", "+fecha.getDate()+" "+meses[fecha.getMonth()]+" "+fecha.getFullYear();
    stop();

    window.onbeforeunload = function(){
            stop();
    }
    $(".fecha").text(sfecha);
    $("#draggable").draggable();    
    modificar_imagenes();        
});


var leyendo = false;
function leer() {
    if(leyendo){
        $("#draggable").attr("src","img/play.png");
        leyendo=false;
        stop();
    }else{
        $("#draggable").attr("src","img/stop.png");
        leyendo=true;
        var text = $("#descripcion").text();    
        reproducir(text);        
    }    
}

function modificar_imagenes(){
    $("#descripcion").find("img").addClass("img-responsive");
    $("#descripcion").find("img").css("height","");
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

(function ($) {
    $.get = function (key) {
        key = key.replace(/[\[]/, '\\[');
        key = key.replace(/[\]]/, '\\]');
        var pattern = "[\\?&]" + key + "=([^&#]*)";
        var regex = new RegExp(pattern);
        var url = unescape(window.location.href);
        var results = regex.exec(url);
        if (results === null) {
            return null;
        } else {
            return results[1];
        }
    }
})(jQuery); 

!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");

function mi_shared(id){
	var link = 'http://kandire.bo/ver_noticia.jsp?id_noticia='+parseInt(id);
	window.open( 'https://www.facebook.com/sharer/sharer.php?u='+link,'_blank', 'width=600,height=400');
}
