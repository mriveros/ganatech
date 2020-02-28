$(function(){

  //----------------------- BOTON GUARDAR CONTROLADOR--------------------//
  $("#btn-guardar-controlador").bind("click", function(){

    $("#msg-agregar-controlador").remove();
    var valido = true;
    
    if($("#controlador_descripcion").val().length == 0){
     
      alerta_formulario($("#controlador_descripcion"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#controlador_descripcion"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de guardar ?")
      if(x) $("#form-agregar-controlador").submit();
    }
    return false;
  
  })
  //----------------------------------------------------------------------//
  //-----------------------BOTON ACTUALIZAR CONTROLADOR-------------------//
  $("#btn-actualizar-controlador").bind("click", function(){

    $("#msg-editar-controlador").remove();
    var valido = true;
    
    if($("#controlador_descripcion").val().length == 0){
     
      alerta_formulario($("#controlador_descripcion"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#controlador_descripcion"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar ?")
      if(x) $("#form-editar-controlador").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//
  //----------------------- BOTON GUARDAR ACCION--------------------//
  $("#btn-guardar-accion").bind("click", function(){

    $("#msg-agregar-accion").remove();
    var valido = true;
    
    if($("#accion_descripcion").val().length == 0){
     
      alerta_formulario($("#accion_descripcion"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#accion_descripcion"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de guardar ?")
      if(x) $("#form-agregar-accion").submit();
    }
    return false;
  
  })
  //----------------------------------------------------------------------//
  //-----------------------BOTON ACTUALIZAR ACCION-------------------//
  $("#btn-actualizar-accion").bind("click", function(){

    $("#msg-editar-accion").remove();
    var valido = true;
    
    if($("#accion_descripcion").val().length == 0){
     
      alerta_formulario($("#accion_descripcion"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#accion_descripcion"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar ?")
      if(x) $("#form-editar-accion").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//

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

