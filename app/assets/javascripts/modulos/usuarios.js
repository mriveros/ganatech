$(function(){

  //----------------------- BOTON INGRESAR--------------------//
  $("#btn-ingresar").bind("click", function(){

    var valido = true;
    
    if($("#persona_tipo_documento_id").val().length == 0){
     
      alerta_formulario($("#persona_tipo_documento_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_tipo_documento_id"), true); 
    
    }

    if($("#persona_nacionalidad_id").val().length == 0){
     
      alerta_formulario($("#persona_nacionalidad_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_nacionalidad_id"), true); 
    
    }

    if($("#persona_documento").val().length == 0){
     
      alerta_formulario($("#persona_documento"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_documento"), true); 
    
    }

    if($("#usuario_session_password").val().length == 0){
     

      alerta_formulario($("#usuario_session_password"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#usuario_session_password"), true); 

    }
/*
    if($("#perfil_rol_id").val().length == 0){
     

      alerta_formulario($("#perfil_rol_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#perfil_rol_id"), true); 

    }
*/
    if(valido){
      $("#login-form").submit();
    }
    return false;
  
  })
  //-----------------------------------------------------------//
  //------------------- BOTON GUARDAR CUENTA------------------//
  $("#btn-guardar-cuenta").bind("click", function(){

    $("#msg-crear-cuenta").remove();

    var valido = true;
    
    if($("#persona_tipo_documento_id").val().length == 0){
     
      alerta_formulario($("#persona_tipo_documento_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_tipo_documento_id"), true); 
    
    }

    if($("#persona_nacionalidad_id").val().length == 0){
     
      alerta_formulario( $("#persona_nacionalidad_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_nacionalidad_id"), true); 
    
    }

    if($("#persona_documento").val().length == 0){
     
      alerta_formulario( $("#persona_documento"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_documento"), true); 
    
    }

    if($("#persona_nombre").val().length == 0){
     
      alerta_formulario(  $("#persona_nombre"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_nombre"), true); 
    
    }

    if($("#persona_apellido").val().length == 0){
     
      alerta_formulario( $("#persona_apellido"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_apellido"), true); 
    
    }

    if($("#usuario_email").val().length == 0){
     
      alerta_formulario( $("#usuario_email"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_email"), true); 
    
    }

    if($("#perfil_rol_id").val().length == 0){
     
      alerta_formulario( $("#perfil_rol_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#perfil_rol_id"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de registrarse ?")
      if(x) $("#form-crear-cuenta").submit();
    }
    return false;
  
  })
  //-----------------------------------------------------------//
  //------------------- BOTON GUARDAR USUARIO------------------//
  $("#btn-guardar-usuario").bind("click", function(){

    $("#msg-agregar-usuario").remove();

    var valido = true;
    
    if($("#persona_tipo_documento_id").val().length == 0){
     
      alerta_formulario($("#persona_tipo_documento_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_tipo_documento_id"), true); 
    
    }

    if($("#persona_nacionalidad_id").val().length == 0){
     
      alerta_formulario( $("#persona_nacionalidad_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_nacionalidad_id"), true); 
    
    }

    if($("#persona_documento").val().length == 0){
     
      alerta_formulario( $("#persona_documento"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_documento"), true); 
    
    }

    if($("#persona_nombre").val().length == 0){
     
      alerta_formulario(  $("#persona_nombre"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_nombre"), true); 
    
    }

    if($("#persona_apellido").val().length == 0){
     
      alerta_formulario( $("#persona_apellido"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_apellido"), true); 
    
    }

    if($("#usuario_email").val().length == 0){
     
      alerta_formulario( $("#usuario_email"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_email"), true); 
    
    }

    if($("#usuario_password").val().length == 0){
     
      alerta_formulario( $("#usuario_password"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_password"), true); 
    
    }

    if($("#usuario_password_confirmation").val().length == 0){
     
      alerta_formulario( $("#usuario_password_confirmation"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_password_confirmation"), true); 
    
    }

    if($("#agregar_usuario_rol_id").val().length == 0){
     
      alerta_formulario( $("#agregar_usuario_rol_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#agregar_usuario_rol_id"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de guardar ?")
      if(x) $("#form-agregar-usuario").submit();
    }
    return false;
  
  })
  //-----------------------------------------------------------//
  //------------------- BOTON ACTUALIZAR USUARIO -------------------//
  $("#btn-actualizar-usuario").bind("click", function(){

    $("#msg-editar-usuario").remove();
    var valido = true;
    
    if($("#usuario_email").val().length == 0){
     
      alerta_formulario($("#usuario_email"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#usuario_email"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar ?")
      if(x) $("#form-editar-usuario").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//
  //------------------- BOTON ACTUALIZAR PASSWORD -------------------//
  $("#btn-actualizar-password").bind("click", function(){

    $("#msg-reset-password").remove();
    var valido = true;
    
    if($("#usuario_password").val().length == 0){
     
      alerta_formulario( $("#usuario_password"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_password"), true); 
    
    }

    if($("#usuario_password_confirmation").val().length == 0){
     
      alerta_formulario( $("#usuario_password_confirmation"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_password_confirmation"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar la contraseña ?")
      if(x) $("#form-reset-password").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//
  //------------------- BOTON ACTUALIZAR MI PASSWORD -------------------//
  $("#btn-actualizar-mi-password").bind("click", function(){

    $("#msg-reset-mi-password").remove();
    var valido = true;
    
    if($("#usuario_session_password").val().length == 0){
     
      alerta_formulario( $("#usuario_session_password"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_session_password"), true); 
    
    }

    if($("#usuario_password").val().length == 0){
     
      alerta_formulario( $("#usuario_password"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_password"), true); 
    
    }

    if($("#usuario_password_confirmation").val().length == 0){
     
      alerta_formulario( $("#usuario_password_confirmation"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_password_confirmation"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar su contraseña ?")
      if(x) $("#form-reset-password").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//
  //------------------- BOTON ACTUALIZAR MI CUENTA -------------------//
  $("#btn-actualizar-mi-cuenta").bind("click", function(){

    $("#msg-mi-cuenta").remove();
    var valido = true;
    
    if($("#usuario_email").val().length == 0){
     
      alerta_formulario($("#usuario_email"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#usuario_email"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar su información ?")
      if(x) $("#form-mi-cuenta").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//
  //------------------- BOTON GUARDAR RECUPERAR PASSWORD ------------------//
  $("#btn-guardar-recuperar-password").bind("click", function(){

    $("#msg-recuperar-password").remove();

    var valido = true;
    
    if($("#persona_tipo_documento_id").val().length == 0){
     
      alerta_formulario($("#persona_tipo_documento_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_tipo_documento_id"), true); 
    
    }

    if($("#persona_nacionalidad_id").val().length == 0){
     
      alerta_formulario( $("#persona_nacionalidad_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_nacionalidad_id"), true); 
    
    }

    if($("#fecha_nacimiento").val().length == 0){
     
      alerta_formulario( $("#fecha_nacimiento"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#fecha_nacimiento"), true); 
    
    }

    if($("#persona_documento").val().length == 0){
     
      alerta_formulario( $("#persona_documento"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_documento"), true); 
    
    }

    if($("#persona_nombre").val().length == 0){
     
      alerta_formulario(  $("#persona_nombre"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_nombre"), true); 
    
    }

    if($("#persona_apellido").val().length == 0){
     
      alerta_formulario( $("#persona_apellido"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#persona_apellido"), true); 
    
    }

    if($("#usuario_email").val().length == 0){
     
      alerta_formulario( $("#usuario_email"), false); 
      valido = false;

    }else{
      
      alerta_formulario( $("#usuario_email"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de recuperar su contraseña ?")
      if(x) $("#form-recuperar-password").submit();
    }
    return false;
  
  })
  //-----------------------------------------------------------//

})

//----------------------- ALERTA PARA FOMULARIOS ---------------//
function alerta_formulario(elemento, estado){
  
  if(estado){
  
    elemento.attr("style", "border:1px solid green;");
    elemento.parent().next().html("<span class='glyphicon glyphicon-ok' style='color:green;padding-top:20px;'></span>");
  
  }else{
 
    elemento.attr("style", "border:1px solid red;");
    elemento.parent().next().html("<span class='glyphicon glyphicon-remove' style='color:red;padding-top:20px;'></span>");

  }

}
//--------------------------------------------------------------//
// --------------------- BUSCAR PERSONA ------------------------//
function buscar_persona(tipo_documento_id, nacionalidad_id, documento, ruta){

  $("#msg-documento-persona").remove();

  $.ajax({
    type: 'GET',
    url: ruta,
    data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento:documento},
    success: function(data){
      
      if(data != null){
          
        $("#persona_documento").next();
        
        $("#persona_nombre").val(data.nombre_persona); 
        $("#persona_apellido").val(data.apellido_persona);
        $("#usuario_email").focus();
          
      }else{


        $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Esta persona no existe, comuniquese a rue@mec.gov.py adjuntando copia del documento de identidad para registrar la persona y habilitar la creación del usuario.</span>").insertAfter("#persona_documento");

        $("#persona_nombre").val('');
        $("#persona_apellido").val('');
          
      }
    },
    typeData: 'json'     
  })
}
//--------------------------------------------------------//
// --------------------- BUSCAR PERSONA ------------------------//
function buscar_persona_v2(tipo_documento_id, nacionalidad_id, documento, ruta, ruta_agregar_persona){

  $("#msg-documento-persona").remove();
  $('#buscar_perso').html('');
  $.ajax({
    type: 'GET',
    url: ruta,
    data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento:documento},
    success: function(data){
      
      if(data != null){
          
        $("#persona_documento").next();
        
        $("#persona_nombre").val(data.nombre_persona); 
        $("#persona_apellido").val(data.apellido_persona);
        $("#usuario_password").val(data.documento_persona);
        $("#usuario_password_confirmation").val(data.documento_persona);
        $("#usuario_email").focus();
          
      }else{
        $('#buscar_perso').html('<div class="alert alert-danger"><span class="glyphicon glyphicon-info-sign"></span>\n\
        Esta persona no existe, debe registrar previamente la persona para la creación de usuarios, corroborando previamente con copia del documento.\n\
        <a href="' + ruta_agregar_persona + '" class="btn btn-primary btn-xs" target="_blank" style="margin-left:10px;">Agregar Persona</a></div>');
        /*$("<span id='msg-documento-persona' style='color:red;font-size:10px;margin: 10px 0 0 10px;'>Esta persona no existe, debe registrar previamente la persona para la creación de usuarios, corroborando previamente con copia del documento.<a href='" + ruta_agregar_persona + "' class='btn btn-primary btn-xs' target='_blank' style='margin-left:10px;'>Agregar Persona</a></span>").insertAfter("#persona_documento");*/

        $("#persona_nombre").val('');
        $("#persona_apellido").val('');
        $("#usuario_password").val('');
        $("#usuario_password_confirmation").val('');
          
      }
    },
    typeData: 'json'     
  })
}
//--------------------------------------------------------//
// --------------------- BUSCAR USUARIO ------------------------//
function buscar_usuario(tipo_documento_id, nacionalidad_id, documento, fecha_nacimiento, ruta){

  $("#msg-documento-persona").remove();

  $.ajax({
    type: 'GET',
    url: ruta,
    data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento:documento, fecha_nacimiento: fecha_nacimiento},
    success: function(data){
      
      if(data != null){
          
        $("#persona_documento").next();
        
        $("#persona_nombre").val(data.nombre_persona); 
        $("#persona_apellido").val(data.apellido_persona);
        $("#usuario_email").val(data.usuario_email);

          
      }else{


        $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Usuario no encontrado.</span>").insertAfter("#persona_documento");

        $("#persona_nombre").val('');
        $("#persona_apellido").val('');
        $("#usuario_email").val('');
          
      }
    },
    typeData: 'json'     
  })
}
//--------------------------------------------------------------------//
// -------------------------- BUSCAR USUARIO ------------------------//
function buscar_usuario_v2(tipo_documento_id, nacionalidad_id, documento, ruta){

  $("#msg-documento-persona").remove();

  $.ajax({
    type: 'GET',
    url: ruta,
    data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento:documento},
    success: function(data){
      
      if(data != null){
          
        $("#persona_documento").next();
        
        $("#persona_nombre").val(data.nombre_persona); 
        $("#persona_apellido").val(data.apellido_persona);
        $("#email").val(data.correo_electronico);
        $("#persona_id").val(data.id);
        $("#descripcion").focus();
          
      }else{


        $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Esta persona no existe, comuniquese a rue@mec.gov.py adjuntando copia del documento de identidad para registrar la persona y habilitar la creación del usuario.</span>").insertAfter("#persona_documento");

        $("#persona_nombre").val('');
        $("#persona_apellido").val('');
          
      }
    },
    typeData: 'json'     
  })
}


