$(function(){

  //----------------------- BOTON GUARDAR MATRICULACION -----------------------//
  $("#btn-guardar-matriculacion, #btn-guardar-matriculacion-abajo").bind("click", function(){

    $("#msg-agregar-matriculacion").remove();
    var valido = true;
    var msg = "";
    
    if ($("#seccion").val() == '1'){

      if($("#fecha_matriculacion").val().length == 0){
     
        alerta_formulario($("#fecha_matriculacion"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#fecha_matriculacion"), true); 
    
      }

      if($("#departamento_institucion_id").val().length == 0){
     
        alerta_formulario($("#departamento_institucion_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#departamento_institucion_id"), true); 
    
      }

      if($("#jurisdiccion_institucion_id").val().length == 0){
     
        alerta_formulario($("#jurisdiccion_institucion_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#jurisdiccion_institucion_id"), true); 
    
      }
/*
      if($("#localidad_institucion_id").val().length == 0){
     
        alerta_formulario($("#localidad_institucion_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#localidad_institucion_id"), true); 
    
      }

      if($("#oferta_educativa").val().length == 0){
     
        alerta_formulario($("#oferta_educativa"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#oferta_educativa"), true); 
    
      }
*/
      if($("#oferta_educativa_id").val().length == 0){
     
        alerta_formulario($("#oferta_educativa_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#oferta_educativa_id"), true); 
    
      }

      if($("#turno_id").val().length == 0){
     [3]
        alerta_formulario($("#turno_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#turno_id"), true); 
    
      }

      if($("#nivel_educativo_id").val().length == 0){
     
        alerta_formulario($("#nivel_educativo_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#nivel_educativo_id"), true); 
    
      }

      if($("#modalidad_nivel_id").val().length == 0){
     
        alerta_formulario($("#modalidad_nivel_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#modalidad_nivel_id"), true); 
    
      }

      if($("#modalidad_nivel_id").length > 0 ){
      
        if($("#modalidad_nivel_id").val() != 2 && $("#modalidad_nivel_id").val() != 12 ){

          if($("#curso_id").val().length == 0){
     
            alerta_formulario($("#curso_id"), false); 
            valido = false;

          }else{
      
            alerta_formulario($("#curso_id"), true); 
    
          }

          if($("#especialidad_id").val().length == 0){
     
            alerta_formulario($("#especialidad_id"), false); 
            valido = false;

          }else{
      
            alerta_formulario($("#especialidad_id"), true); 
    
          }
 

        }

      }
     
      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }

    }

    if ($("#seccion").val() == '2'){

      if($("#tipo_documento_id").val().length == 0){
     
        alerta_formulario($("#tipo_documento_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#tipo_documento_id"), true); 
        /*validación de tipo de documento 14/09/17*/
            if ($("#tipo_documento_id").val()==='6' && $("#nacionalidad_id").val()==='1') {
              if($.trim($("#fecha_inscripcion").val()).length === 0){

                  alerta_formulario($("#fecha_inscripcion"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#fecha_inscripcion"), true); 

                } 
                if($.trim($("#folio").val()).length === 0){

                  alerta_formulario($("#folio"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#folio"), true); 

                }
                if($.trim($("#libro").val()).length === 0){

                  alerta_formulario($("#libro"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#libro"), true); 

                }
                if($.trim($("#acta").val()).length === 0){

                  alerta_formulario($("#acta"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#acta"), true); 

                }                
            }else{
                alerta_formulario($("#fecha_inscripcion"), true); 
                alerta_formulario($("#folio"), true); 
                alerta_formulario($("#libro"), true);
                alerta_formulario($("#acta"), true); 
//                validar solo si el tipo de documento es distinto a certificado de nacimiento
                if($("#documento_persona").val().length == 0 && $("#tipo_documento_id").val()!=='5'){

                  alerta_formulario($("#documento_persona"), false); 
                  valido = false;

                }else{

                  alerta_formulario($("#documento_persona"), true); 

                }                
            }        
        /*-------------------------------------------*/
    
      }

      if($("#nacionalidad_id").val().length == 0){
     
        alerta_formulario($("#nacionalidad_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#nacionalidad_id"), true); 
    
      }
      if($("#nombre_persona").val().length == 0){
     
        alerta_formulario($("#nombre_persona"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#nombre_persona"), true); 
    
      }

      if($("#apellido_persona").val().length == 0){
     
        alerta_formulario($("#apellido_persona"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#apellido_persona"), true); 
    
      }

      if($("#fecha_nacimiento").val().length == 0){
     
        alerta_formulario($("#fecha_nacimiento"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#fecha_nacimiento"), true); 
    
      }
      if($("#genero_id").val().length == 0){
     
        alerta_formulario($("#genero_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#genero_id"), true); 
    
      }

      if($("#departamento_id").val().length == 0){
     
        alerta_formulario($("#departamento_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#departamento_id"), true); 
    
      }

      if($("#jurisdiccion_id").val().length == 0){
     
        alerta_formulario($("#jurisdiccion_id"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#jurisdiccion_id"), true); 
    
      }

      if(!$("input:radio[name=caracteristica_estudiante_repitente]").is(':checked')){
 
        msg += "Seleccione si es o no un repitente.\n" 
        valido = false;      
        
      }

      if($("input:radio[name=caracteristica_es_indigena]").is(':checked')){
     
        if($("#caracteristica_es_indigena_1").is(':checked')){

          if(!$("input:radio[name=comunidad_indigena_id]").is(':checked')){
 
            msg += "Seleccione una comunidad indigena.\n" 
            valido = false;      
        
          }else{
        
            if($("#comunidad_indigena_id_20").is(':checked') && $("#comunidad_indigena_especificar").val().length == 0){
            
              msg += "Especifique la comunidad indigena.\n" 
              valido = false;         
          
            } 

          }

          if(!$("input:radio[name=caracteristica_carnet_indigena]").is(':checked')){
 
            msg += "Seleccione si o no posee carnet indigena.\n" 
            valido = false;      
        
          }else{
        
            if($("#caracteristica_carnet_indigena_23").is(':checked') && $("#carnet_indigena").val().length == 0){
            
              msg += "Especifique el Nro de carnet indigena.\n" 
              valido = false;         
          
            } 

          }

        }

      }else{
 
        msg += "Seleccione si o no pertenece a un pueblo indigena.\n" 
        valido = false;         
      
      }

      if(!$("input:radio[name=caracteristica_afrodescendiente]").is(':checked')){
 
        msg += "Seleccione si o no es afrodescendiente o camba.\n" 
        valido = false;      
        
      }

      if(!$("input:radio[name=caracteristica_idioma_utilizado]").is(':checked')){
 
        msg += "Seleccione el idioma que habla la mayor parte del tiempo.\n" 
        valido = false;      
        
      }else{
      
        if($("#caracteristica_idioma_utilizado_1002").is(':checked') && $("#caracteristica_idioma_utilizado_etnico_id").val().length == 0){
 
          msg += "Seleccione el idioma etnico que utiliza.\n" 
          valido = false;      
        
        }

        if($("#caracteristica_idioma_utilizado_1003").is(':checked') && $("#caracteristica_idioma_utilizado_otros_id").val().length == 0){
 
          msg += "Seleccione otro idioma que utiliza.\n" 
          valido = false;      
        
        }

      }

      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }else{
      
        alert(msg);
        
      }

    }

    if ($("#seccion").val() == '3'){ 

      if($("input:radio[name=discapacidad_id]").is(':checked')){
      
        if($("#discapacidad_id_147").is(':checked')){
         
          if(!$("input:radio[name=auditiva_id]").is(':checked') && !$("input:radio[name=visual_id]").is(':checked') && !$("input:radio[name=psicosocial_id]").is(':checked') && !$("input:radio[name=intelectual_id]").is(':checked') && $("#fisica_descripcion").val().length == 0 && !$("#aprendizaje_lectoescritura_id_159").is(':checked') && !$("#aprendizaje_calculo_id_160").is(':checked') && !$("#aprendizaje_otro_id_161").is(':checked') && !$("#lenguaje_comprension_id_162").is(':checked') && !$("#lenguaje_expresion_id_163").is(':checked') && !$("#lenguaje_otro_id_164").is(':checked') && $("#otras_discapacidades").val().length == 0 ){
            
            msg += "Especifique alguna discapacidad o trastorno.\n" 
            valido = false;         
          
          }else{
          
            if($("#aprendizaje_otro_id_161").is(':checked') && $("#aprendizaje_otro").val().length == 0){
 
              msg += "Especifique otro trastorno del aprendizaje.\n" 
              valido = false;         
            
            }

            if($("#lenguaje_otro_id_164").is(':checked') && $("#lenguaje_otro").val().length == 0){
 
              msg += "Especifique otro trastorno del lenguaje.\n" 
              valido = false;         
            
            }

          } 

        }

        if($("#con_diagnostico_id_166").is(':checked') && $("#diagnostico_descripcion").val().length == 0){
 
          msg += "Especifique el diagnóstico médico.\n" 
          valido = false;         
            
        }

      }else{
 
        msg += "Seleccione si o no posee discapacidad.\n" 
        valido = false;         
      
      }

      if($("#nombre_contacto1").val().length == 0 || $("#apellido_contacto1").val().length == 0 || $("#telefono_contacto1").val().length == 0){
      
        msg += "Agregue por lo menos los datos de un contacto.\n" 
        valido = false;         
 

      }

      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }else{
      
        alert(msg);

      }

    }

    if ($("#seccion").val() == '4'){

    
      if($("#ruex3").val() == '1' || $("#ruex3").val() == '2') {

      if($("#gente_casa_id_168").is(':checked')){
 
        if($("#tipo_documento_padre_id").val().length == 0){
        
          msg += "El tipo de documento del padre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#nacionalidad_padre_id").val().length == 0){
        
          msg += "La nacionalidad del padre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#nombre_padre").val().length == 0){
        
          msg += "El nombre del padre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#apellido_padre").val().length == 0){
        
          msg += "El apellido del padre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#fecha_nacimiento_padre").val().length == 0){
        
          msg += "La fecha de nacimiento del padre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#genero_padre_id").val().length == 0){
        
          msg += "El genero del padre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#telefono_padre").val().length == 0 && $("#celular_padre").val().length == 0 && $("#correo_electronico_padre").val().length == 0){
        
          msg += "Ingrese el teléfono, celular o correo electrónico de contacto del padre.\n" 
          valido = false;         
        
        }

      }

      if($("#gente_casa_id_169").is(':checked')){
 
        if($("#tipo_documento_madre_id").val().length == 0){
        
          msg += "El tipo de documento de la madre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#nacionalidad_madre_id").val().length == 0){
        
          msg += "La nacionalidad de la madre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#nombre_madre").val().length == 0){
        
          msg += "El nombre de la madre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#apellido_madre").val().length == 0){
        
          msg += "El apellido de la madre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#fecha_nacimiento_madre").val().length == 0){
        
          msg += "La fecha de nacimiento de la madre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#genero_madre_id").val().length == 0){
        
          msg += "El genero de la madre no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#telefono_madre").val().length == 0 && $("#celular_madre").val().length == 0 && $("#correo_electronico_madre").val().length == 0){
        
          msg += "Ingrese el teléfono, celular o correo electrónico de contacto de la madre.\n" 
          valido = false;         
        
        }

      }

      if($("#gente_casa_id_172").is(':checked')){
 
        if($("#tipo_documento_tutor_id").val().length == 0){
        
          msg += "El tipo de documento del tutor no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#nacionalidad_tutor_id").val().length == 0){
        
          msg += "La nacionalidad del tutor no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#nombre_tutor").val().length == 0){
        
          msg += "El nombre del tutor no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#apellido_tutor").val().length == 0){
        
          msg += "El apellido del tutor no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#fecha_nacimiento_tutor").val().length == 0){
        
          msg += "La fecha de nacimiento del tutor no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#genero_tutor_id").val().length == 0){
        
          msg += "El genero del tutor no puede quedar vacio.\n" 
          valido = false;         
        
        }

        if($("#telefono_tutor").val().length == 0 && $("#celular_tutor").val().length == 0 && $("#correo_electronico_tutor").val().length == 0){
        
          msg += "Ingrese el teléfono, celular o correo electrónico de contacto del tutor.\n" 
          valido = false;         
        
        }

      }
      }
      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }else{
      
        alert(msg);

      }

    }

    if ($("#seccion").val() == '5'){

      if($("#cantidad_personas_casa").val().length == 0){
     
        alerta_formulario($("#cantidad_personas_casa"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#cantidad_personas_casa"), true); 
    
      }

      if($("#cantidad_piezas_dormir").val().length == 0){
     
        alerta_formulario($("#cantidad_piezas_dormir"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#cantidad_piezas_dormir"), true); 
    
      }

      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }

    }

    if ($("#seccion").val() == '6'){

      if($("input:radio[name=recibe_beneficio]").is(':checked')){
      
        if($("#recibe_beneficio_255").is(':checked')){
         
          if(!$("#beneficio_id_257").is(':checked') && !$("#beneficio_id_258").is(':checked') && !$("#beneficio_id_259").is(':checked') && !$("#beneficio_id_260").is(':checked') && !$("#beneficio_id_261").is(':checked') ){
            
            msg += "Especifique algun beneficio.\n" 
            valido = false;         
          
          } 

        }

      }else{
      
        msg += "Seleccione si o no recibe beneficio.\n" 
        valido = false;     
      
      }

      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }else{
      
        alert(msg);
      
      }

    }

    if ($("#seccion").val() == '7'){
/*
      if(!$("#confirmar_formulario").is(':checked')){
      
        alerta_formulario($("#confirmar_formulario"), false); 
        valido = false;

      }else{
      
        alerta_formulario($("#confirmar_formulario"), true); 

      }
*/
      if(valido){
      
        var x = confirm("Está seguro de guardar ?")
        if(x) $("#form-matriculacion").submit();

      }

    }

    return false;
  
  })
  
  //----------------------------------------------------------------------//
  

});

//----------------------- ALERTA PARA FOMULARIOS ---------------//
function alerta_formulario(elemento, estado){
 
  style = elemento.attr('style');

  if(estado){
  
    elemento.attr("style", style + "border:1px solid green;");
    elemento.parent().next().html("<span class='glyphicon glyphicon-ok' style='color:green;padding-top:20px;'></span>");
  
  }else{
 
    elemento.attr("style", style + "border:1px solid red;");
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
          
        $("#documento_persona").next();
        
        $("#nombre_persona").val(data.nombre_persona); 
        $("#apellido_persona").val(data.apellido_persona);
        $("#fecha_nacimiento").val(formatear_fecha(data.fecha_nacimiento));
        $("#genero_id").val(data.genero_id);
          
      }else{


        $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Persona no encontrada. Envie una copia de su documento de identidad al correo rue@mec.gov.py para registrarla.</span>").insertAfter("#documento_persona");

        $("#nombre_persona").val('');
        $("#apellido_persona").val('');
        $("#fecha_nacimiento").val('');
        $("#genero_id").val('');
        
        if(tipo_documento_id == '1'){

          $("#nombre_persona").attr("readonly", true);
          $("#apellido_persona").attr("readonly", true);

        }else{
          
          $("#nombre_persona").attr("readonly", false);
          $("#apellido_persona").attr("readonly", false);
        
        }
          
      }
    },
    typeData: 'json'     
  })
}
//--------------------------------------------------------------------//
// --------------------- BUSCAR PERSONA V2 ------------------------//
function buscar_persona_v2(tipo_documento_id, nacionalidad_id, documento, fecha_nacimiento, ruta){

  $("#msg-documento-persona").remove();

  $.ajax({
    type: 'GET',
    url: ruta,
    data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento:documento, fecha_nacimiento: fecha_nacimiento},
    success: function(data){
      
      if(data != null){
          
        $("#documento_persona").next();
        
        $("#nombre_persona").val(data.nombre_persona); 
        $("#apellido_persona").val(data.apellido_persona);
        $("#fecha_nacimiento").val(formatear_fecha(data.fecha_nacimiento));
        $("#genero_id").val(data.genero_id);
        $("#departamento_id").focus();
          
      }else{


        $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Persona no encontrada. Envie una copia de su documento de identidad al correo rue@mec.gov.py para registrarla.</span>").insertAfter("#documento_persona");

        $("#nombre_persona").val('');
        $("#apellido_persona").val('');
        //$("#fecha_nacimiento").val('');
        $("#genero_id").val('');
        
        if(tipo_documento_id == '1'){

          $("#nombre_persona").attr("readonly", true);
          $("#apellido_persona").attr("readonly", true);

        }else{
          $("#msg-documento-persona").remove();
          $("<span id='msg-documento-persona' style='color:blue;padding-top:20px;font-size:10px;'>Persona no encontrada. Ingrese los demás datos para registrar.</span>").insertAfter("#documento_persona");
     
          $("#nombre_persona").attr("readonly", false);
          $("#apellido_persona").attr("readonly", false);
          $("#nombre_persona").focus();
        
        }
          
      }
    },
    typeData: 'json'     
  })
}
//--------------------------------------------------------------------//
// --------------------- BUSCAR PERSONA PADRES ------------------------//
function buscar_persona_padres(tipo_documento_id, nacionalidad_id, documento, prefijo, ruta){

  $("#msg-documento-persona-" + prefijo).remove();

  $.ajax({
    type: 'GET',
    url: ruta,
    data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento:documento },
    success: function(data){
      
      if(data != null){
        
        $("#nombre_"+prefijo).val(data.nombre_persona); 
        $("#apellido_"+prefijo).val(data.apellido_persona);
        $("#fecha_nacimiento_"+prefijo).val(formatear_fecha(data.fecha_nacimiento));
        $("#genero_"+prefijo+"_id").val(data.genero_id);
        $("#telefono_"+prefijo).val(data.telefono);
        $("#celular_"+prefijo).val(data.celular);
        $("#correo_electronico_"+prefijo).val(data.correo_electronico);

        $("#telefono_"+prefijo).focus();

      }else{


        $("<span id='msg-documento-persona-" + prefijo + "' style='color:red;padding-top:20px;font-size:10px;'>Persona no encontrada. Envie una copia de su documento de identidad al correo rue@mec.gov.py para registrarla.</span>").insertAfter("#documento_"+prefijo);

        $("#nombre_"+prefijo).val('');
        $("#apellido_"+prefijo).val('');
        $("#fecha_nacimiento_"+prefijo).val('');
        $("#genero_"+prefijo+"_id").val('');
        $("#telefono_"+prefijo).val('');
        $("#celular_"+prefijo).val('');
        $("#correo_electronico_"+prefijo).val('');
          
      }
    },
    typeData: 'json'     
  })
}
//--------------------------------------------------------//

