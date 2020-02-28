$(function(){

  //----------------------- BOTON GUARDAR ROL -----------------------//
  $("#btn-guardar-rol").bind("click", function(){

    $("#msg-agregar-rol").remove();
    var valido = true;
    
    if($("#rol_descripcion").val().length == 0){
     
      alerta_formulario($("#rol_descripcion"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#rol_descripcion"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de guardar ?")
      if(x) $("#form-agregar-rol").submit();
    }
    return false;
  
  })
  //----------------------------------------------------------------------//
  //-----------------------BOTON ACTUALIZAR ROL------- -------------------//
  $("#btn-actualizar-rol").bind("click", function(){

    $("#msg-editar-rol").remove();
    var valido = true;
    
    if($("#rol_descripcion").val().length == 0){
     
      alerta_formulario($("#rol_descripcion"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#rol_descripcion"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar ?")
      if(x) $("#form-editar-rol").submit();
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
