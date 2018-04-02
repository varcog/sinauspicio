var url = "noticias_controller";
$(document).ready(function(){
    var tipo = sessionStorage.getItem("tipo_noticia");
    $("#tipo_noticia").text(tipo);
    var fecha = new Date();
    var sfecha = fecha.getDate()+"/"+(fecha.getMonth()+1)+"/"+fecha.getFullYear();
    $("input[name=fecha]").val(sfecha);
    $('.fecha').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'});
    $('.fecha').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true
    });
    cargar();
});

function cargar() {    
    var fecha = $("input[name=fecha]").val();
    var id_categoria = sessionStorage.getItem("id_categoria");;
    $.post(url, {evento: "cargar",fecha:fecha,id_categoria:id_categoria}, function (resp) {
        var json = $.parseJSON(resp);
        /*var select = "";
        $.each(json.subcategorias,function(i,obj){
            select+="<option value='"+obj.id+"'>"+obj.descripcion+"</option>";
        });
        $("select[name=categoria]").html(select);*/
        var cuerpo = "";
        $.each(json.noticias,function(i,obj){
            cuerpo+="<tr>";
            cuerpo+="<td>"+obj.fecha+"</td>";
            cuerpo+="<td>"+obj.lugar+"</td>";
            cuerpo+="<td>"+obj.subcategoria+"</td>";
            cuerpo+="<td>"+obj.estado+"</td>";
            cuerpo+="<td>"+obj.titulo+"</td>";            
            cuerpo+="<td><button type='button' class='fa fa-edit btn btn-block btn-success btn-xs' onclick='modificar("+obj.id+");'></button></td>";
            cuerpo+="<td><button onclick='eliminar("+obj.id+",this);' type='button' class='fa fa-trash-o  btn btn-block btn-danger btn-xs'></button></td>";
            cuerpo+="</tr>";
        });
        $("#cuerpo").html(cuerpo);        
    });
}

function modificar(id) {
    sessionStorage.setItem("id_noticia",id);
    document.location.href="nuevaNoticia.html";
}
function eliminar(id,span) {
    $.post(url, {evento: "eliminar",id:id}, function (resp) {
        if(resp==="true")$(span).parent().parent().remove();
    });
}
 
function nueva_noticia() {
    sessionStorage.setItem("id_noticia",0);
    document.location.href="nuevaNoticia.html";
}