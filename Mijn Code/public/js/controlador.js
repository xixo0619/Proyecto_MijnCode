$("btn-login").click(function() {
    $.ajax({
        url:"/login",
        data:"usuario="+$("#login-usuario").val()+"&contrasena="+$("#login-contrasena").val(),
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus == 0)
                //alert("Credenciales correctas");    
                window.location.href ="panel.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });
});


$("#btn-registro-usuario").click(function(){
    var parametros = "nombre"+$("#txt-nombre-usuario").val() + "&" + 
                     "apellido="+$("#txt-apellido-usuario").val() + "&" +
                     "correo="+$("#txt-correo-usuario").val() + "&" +
                     "nombre_usuario="+$("#txt-usuario").val() + "&" +
                     "contrasena="+$("#txt-contrasena").val();
    $.ajax({
        url: "/registro",
        method: "POST",
        data: parametros,
        datatype:"json",
        success: function(res){
            console.log($("#txt-usuario").val());
            $("#txt-nombre-usuario").val("");
            $("#txt-apellido-usuario").val("");
            $("#txt-correo-usuario").val("");
            $("#txt-usuario").val("");
            $("#txt-contrasena").val(""); 
        }   
    })     
    alert("Registrado exitosamente");             
});