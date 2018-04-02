var url = "publicidad_controller";
$(document).ready(function () {
    cargar();
});

function cargar() {
    $.post(url, {evento: "cargar"}, function (resp) {
        var json = $.parseJSON(resp);
        var cuerpo = "";
        $.each(json, function (i, obj) {
            cuerpo += armar_contenido(obj);
        });
        $("#cuerpo").html(cuerpo);
    });
}
function nueva_publicidad() {
    $.post(url, {evento: "nueva_publicidad"}, function (resp) {
        var obj = $.parseJSON(resp);
        $("#cuerpo").append(armar_contenido(obj));
    });
}

function armar_contenido(obj) {
    var cuerpo = "";
    cuerpo += "<tr>";
    cuerpo += "<td><textarea name='descripcion' onchange='modificar(this," + obj.id + ");'>" + obj.descripcion + "</textarea></td>";
    cuerpo += "<td><input type='checkbox' name='estado' checked='" + obj.estado + "' onchange='modificar(this," + obj.id + ");'/></td>";
    cuerpo += "<td><input type='text' name='fecha' class='fecha' value='" + obj.fecha_expiracion + "' onchange='modificar(this," + obj.id + ");'/></td>";
    cuerpo += "<td><input type='number' name='porc' value='" + obj.porcentaje + "' onchange='modificar(this," + obj.id + ");'/></td>";
    cuerpo += "<td><form>";
    cuerpo += "<img alt='foto' src='" + obj.foto + "' onclick='click_foto(this);' style='width:100px; heigth:100px;'/>";
    cuerpo += "<input type='file' name='file' onchange='upload(this,event);' style='display:none;'/>";
    cuerpo += "<input type='hidden' name='id' value='" + obj.id + "'/>";
    cuerpo += "<input type='hidden' name='evento' value='upload_baner'/>";
    cuerpo += "</form></td>";
    cuerpo += "<td><button onclick='eliminar(" + obj.id + ",this);' type='button' class='fa fa-trash-o  btn btn-block btn-danger btn-xs'></button></td>";
    cuerpo += "</tr>";
    return cuerpo;
}

function click_foto(img) {
    $(img).next().click();
}
function upload(file,event) {
    $("#pgbar").css("width","0%");
    $("#pgbars").css("display","block");
    $(".popup").css("display","block");
    var formData = new FormData($(file).parent()[0]);
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
            if (data === "true") {
                $("#pgbar").css("width","0%");
                $("#pgbars").css("display","none");
                $(".popup").css("display","none");
                var selectedFile = event.target.files[0];
                var reader = new FileReader();

                var imgtag = $(file).prev()[0];
                imgtag.title = selectedFile.name;

                reader.onload = function (event) {
                    imgtag.src = event.target.result;
                };

                reader.readAsDataURL(selectedFile);
            }
        }
    });
}
function modificar(input, id) {
    var tr = $(input).parent().parent();
    var desc = $(tr).find("textarea[name=descripcion]").val();
    var estado = $(tr).find("input[name=estado]").prop("checked");
    var fecha = $(tr).find("input[name=fecha]").val();
    var porc = $(tr).find("input[name=porc]").val();
    $.post(url, {
        evento: "modificar",
        id: id,
        desc: desc,
        estado: estado,
        fecha: fecha,
        porc: porc
    }, function (resp) {

    });
}