var url = "index_ppl_controller";
$(document).ready(function(){
    cargar_menu();
});
function cargar_menu(){
    $.post(url, {evento: "cargar"}, function (resp) {
        var json = $.parseJSON(resp);
         //class="active"
        var cuerpo = "";
        $.each(json,function(i,obj){
            cuerpo += "<li onclick='ver_page("+obj.id+",this);'><a href='javascript:void(0)'><i class='fa "+obj.icon+"'></i>"+obj.descripcion+"</a></li>";
        });
        $("#menu").html(cuerpo);
    });
}
function ver_page(id,li){    
    $("#menu").children().removeClass("active");
    $(li).addClass("active");
    var tipo = $(li).text();
    sessionStorage.setItem("tipo_noticia",tipo);
    sessionStorage.setItem("id_categoria",id);
    $("#frame").attr("src","noticias.html");
}
function ver_page_baner_ingreso(li){    
    $("#menu").children().removeClass("active");
    $(li).addClass("active");
    var tipo = $(li).text();    
    $("#frame").attr("src","publicidad.html");
}