var url = "noticias_controller";

$(document).ready(function(){
    var id_categoria = sessionStorage.getItem("id_categoria");
    var tipo = sessionStorage.getItem("tipo_noticia");
    $("#tipo_noticia").text(tipo);
    
    CKEDITOR.replace('editor1');
    
    //$(".textarea").wysihtml5();
    $('.fecha').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'});
    $('.fecha').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true
    });
    $.post(url, {evento: "cargar_subcategoria",id_categoria:id_categoria}, function (resp) {
        var json = $.parseJSON(resp);
        var cuerpo = "";
        $.each(json,function(i,obj){
            cuerpo+="<option value='"+obj.id+"'>"+obj.descripcion+"</option>";
        });
        $("select[name=subcat]").html(cuerpo);
        var id = sessionStorage.getItem("id_noticia");
        $("input[name=id_noticia]").val(id);
        if(id>0){            
            $.post(url, {evento: "cargar_noticia",id:id}, function (resp) {
                var json = $.parseJSON(resp);
                $("input[name=titulo]").val(json.titulo);
                $("input[name=url_facebook]").val(json.url_facebook);
                $("input[name=url_you_tube]").val(json.url_you_tube);
                $("input[name=lugar]").val(json.lugar);
                $("input[name=fecha]").val(json.fecha);
                $("input[name=fuente]").val(json.fuente);
                CKEDITOR.instances['editor1'].setData(json.descripcion);
                CKEDITOR.on('instanceReady', function(e) {
                    CKEDITOR.instances['editor1'].setData(json.descripcion);
                });                
                $("input[name=subtitulo]").val(json.subtitulo);
                $("select[name=subcat]").val(json.id_sub_categoria);
                if(json.is_portada) $("input[name=cb_portada]").prop("checked",true);
                if(json.estado) $("select[name=estado]").val(1);                 
                else $("select[name=estado]").val(0);
                $(".idfoto").val(0);
                $.each(json.fotos,function(i,obj){
                    $("input[name=desc_foto"+(i+1)+"]").val(obj.descripcion);
                    $("input[name=id_foto"+(i+1)+"]").val(obj.id);
                    $("#img"+(i+1)).attr("src",obj.foto);
                });
            });
        }
        $(document).resize();        
    });
});


function click_file(img) {
    $(img).next().click();
}

function cambiar_foto(id,event) {
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById("img"+id);
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
}

/**
 * Comment
 */
function guardar_noticia() {
    $("#pgbar").css("width","0%");
    $("#pgbars").css("display","block");
    $(".popup").css("display","block");
    for ( instance in CKEDITOR.instances )
    {
        CKEDITOR.instances[instance].updateElement();
    }
    var formData = new FormData($("#form")[0]);
    $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        mimeType: "multipart/form-data",
        contentType: false,
        cache: false,
        processData: false,        
        xhr: function () {
            var myXhr = $.ajaxSettings.xhr();
            if (myXhr.upload) {
                // For handling the progress of the upload
                myXhr.upload.addEventListener('progress', function (e) {
                    if (e.lengthComputable) {
                        /*$('progress').attr({
                         value: e.loaded,
                         max: e.total                            
                         });*/

                        $("#pgbar").css("width", ((e.loaded * 100) / e.total).toFixed(1) + "%");
                        /*var kb = e.loaded/1024;
                         if(kb<1000){
                         $("#total").text(((e.total/1024)).toFixed(2)+" Kb");
                         $("#restante").text(((e.loaded/1024)).toFixed(2)+" Kb");
                         }else if(kb<1024000){
                         $("#total").text(((e.total/1024)/1024).toFixed(2)+" Mb");
                         $("#restante").text(((e.loaded/1024)/1024).toFixed(2)+" Mb");
                         }else{
                         $("#total").text((((e.total/1024)/1024)/1024).toFixed(2)+" Gb");
                         $("#restante").text((((e.loaded/1024)/1024)/1024).toFixed(2)+" Gb");
                         }*/
                    }
                }, false);
            }
            return myXhr;
        },
        success: function (data, textStatus, jqXHR)
        {
            if(data==="true") document.location.href="noticias.html";
        }
    });
}