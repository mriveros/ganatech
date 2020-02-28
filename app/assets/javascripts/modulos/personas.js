        jQuery("document").ready(
        function(){
            validarcerti();
        }
        );

$(function(){
  
  //
  //----------------------- BOTON GUARDAR PERSONA -----------------------//
  $("#btn-guardar-persona").bind("click", function(){

    $("#msg-agregar-persona").remove();
    var valido = true;
    
    if(($("#persona_tipo_documento_id").val().replace(/\s/g,'')).length == 0){
     
      alerta_formulario($("#persona_tipo_documento_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_tipo_documento_id"), true); 
            if ($("#persona_tipo_documento_id").val()==='6' && $("#persona_nacionalidad_id").val()==='1') {
              if($.trim($("#persona_fecha_inscripcion").val()).length === 0){

                  alerta_formulario($("#persona_fecha_inscripcion"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_fecha_inscripcion"), true); 

                } 
                if(($.trim($("#persona_folio").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_folio"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_folio"), true); 

                }
              if(($.trim($("#persona_numero_oficina").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_numero_oficina"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_numero_oficina"), true); 

                }
                if(($.trim($("#persona_libro").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_libro"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_libro"), true); 

                }
                if(($.trim($("#persona_acta").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_acta"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_acta"), true); 

                }                
            }else{
                alerta_formulario($("#persona_fecha_inscripcion"), true);
                alerta_formulario($("#persona_numero_oficina"), true);
                alerta_formulario($("#persona_folio"), true); 
                alerta_formulario($("#persona_libro"), true);
                alerta_formulario($("#persona_acta"), true); 
//                validar solo si el tipo de documento es distinto a certificado de nacimiento
                if(($("#persona_documento_persona").val().replace(/\s/g,'')).length == 0 && $("#persona_tipo_documento_id").val()!=='5'){

                  alerta_formulario($("#persona_documento_persona"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_documento_persona"), true); 

                }                
            }      
    
    }

    if($("#persona_nacionalidad_id").val().length == 0){
     
      alerta_formulario($("#persona_nacionalidad_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_nacionalidad_id"), true); 
    
    }


    if(($("#persona_nombre_persona").val().replace(/\s/g,'')).length == 0){
     
      alerta_formulario($("#persona_nombre_persona"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_nombre_persona"), true); 
    
    }

    if(($("#persona_apellido_persona").val().replace(/\s/g,'')).length == 0){
     
      alerta_formulario($("#persona_apellido_persona"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_apellido_persona"), true); 
    
    }

    if($("#persona_fecha_nacimiento").val().length == 0){
     
      alerta_formulario($("#persona_fecha_nacimiento"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_fecha_nacimiento"), true); 
    
    }

    if($("#persona_genero_id").val().length == 0){
     
      alerta_formulario($("#persona_genero_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_genero_id"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de guardar ?")
      if(x) $("#form-agregar-persona").submit();
    }
    return false;
  
  })
  //----------------------------------------------------------------------//
  //-----------------------BOTON ACTUALIZAR PERSONA------- -------------------//
  $("#btn-actualizar-persona").bind("click", function(){

    $("#msg-editar-persona").remove();
    var valido = true;
    
    if(($("#persona_tipo_documento_id").val().replace(/\s/g,'')).length == 0){
     
      alerta_formulario($("#persona_tipo_documento_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_tipo_documento_id"), true); 
      
            if ($("#persona_tipo_documento_id").val()==='6' && $("#persona_nacionalidad_id").val()==='1') {
              
              if($.trim($("#persona_fecha_inscripcion").val()).length === 0){

                  alerta_formulario($("#persona_fecha_inscripcion"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_fecha_inscripcion"), true); 

                } 
              if(($.trim($("#persona_numero_oficina").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_numero_oficina"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_numero_oficina"), true); 

                }                
                if(($.trim($("#persona_folio").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_folio"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_folio"), true); 

                }
                if(($.trim($("#persona_libro").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_libro"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_libro"), true); 

                }
                if(($.trim($("#persona_acta").val()).replace(/\s/g,'')).length === 0){

                  alerta_formulario($("#persona_acta"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_acta"), true); 

                }                
            }else{
                alerta_formulario($("#persona_fecha_inscripcion"), true); 
                alerta_formulario($("#persona_numero_oficina"), true);
                alerta_formulario($("#persona_folio"), true); 
                alerta_formulario($("#persona_libro"), true);
                alerta_formulario($("#persona_acta"), true); 
//                validar solo si el tipo de documento es distinto a certificado de nacimiento
                if(($("#persona_documento_persona").val().replace(/\s/g,'')).length == 0 && $("#persona_tipo_documento_id").val()!=='5'){

                  alerta_formulario($("#persona_documento_persona"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#persona_documento_persona"), true); 

                }                    

                
            }      
    
    }

    if($("#persona_nacionalidad_id").val().length == 0){
     
      alerta_formulario($("#persona_nacionalidad_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_nacionalidad_id"), true); 
    
    }

    if($("#persona_nombre_persona").val().length == 0){
     
      alerta_formulario($("#persona_nombre_persona"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_nombre_persona"), true); 
    
    }

    if($("#persona_apellido_persona").val().length == 0){
     
      alerta_formulario($("#persona_apellido_persona"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_apellido_persona"), true); 
    
    }

    if($("#persona_fecha_nacimiento").val().length == 0){
     
      alerta_formulario($("#persona_fecha_nacimiento"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_fecha_nacimiento"), true); 
    
    }

    if($("#persona_genero_id").val().length == 0){
     
      alerta_formulario($("#persona_genero_id"), false); 
      valido = false;

    }else{
      
      alerta_formulario($("#persona_genero_id"), true); 
    
    }

    if(valido){
      
      var x = confirm("Está seguro de actualizar ?")
      if(x) $("#form-editar-persona").submit();
    }
    return false;

  })
  //---------------------------------------------------------------------//

})

//----------------------- ALERTA PARA FOMULARIOS ---------------//
function alerta_formulario(elemento, estado){
  
  if(estado){    
    elemento.attr("style", "border:1px solid green;text-transform:uppercase;");
    elemento.parent().next().html("<span class='glyphicon glyphicon-ok' style='color:green;padding-top:20px;'></span>");
  
  }else{
    //alert(elemento.);
    elemento.attr("style", "border:1px solid red;text-transform:uppercase;");
    elemento.parent().next().html("<span class='glyphicon glyphicon-remove' style='color:red;padding-top:20px;'></span>");

  }

}
//--------------------------------------------------------------//
