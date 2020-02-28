$(function () {

 //----------------------- BOTON GUARDAR MATRICULACION -----------------------//
 $("#btn-guardar-matriculacion-superior, #btn-guardar-matriculacion-superior-abajo").bind("click", function () {

  $("#msg-agregar-matriculacion-superior").remove();
  var valido = true;
  var msg = "";

  if ($("#seccion").val() == '1') {

   if ($("#fecha_matriculacion").val().length == 0) {

    alerta_formulario($("#fecha_matriculacion"), false);
    valido = false;

   } else {

    alerta_formulario($("#fecha_matriculacion"), true);

   }

   if ($("#departamento_institucion_id").val().length == 0) {

    alerta_formulario($("#departamento_institucion_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#departamento_institucion_id"), true);

   }

   if ($("#jurisdiccion_institucion_id").val().length == 0) {

    alerta_formulario($("#jurisdiccion_institucion_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#jurisdiccion_institucion_id"), true);

   }

   if ($("#oferta_educativa_id").val().length == 0) {

    alerta_formulario($("#oferta_educativa_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#oferta_educativa_id"), true);

   }

   if ($("#turno_id").val().length == 0) {

    alerta_formulario($("#turno_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#turno_id"), true);

   }

   if ($("#tipo_formacion_id").val().length == 0) {

    alerta_formulario($("#tipo_formacion_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#tipo_formacion_id"), true);

   }

   if ($("#titulo_id").val().length == 0) {

    alerta_formulario($("#titulo_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#titulo_id"), true);

   }

   if ($("#titulo_area_id").val().length == 0) {

    alerta_formulario($("#titulo_area_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#titulo_area_id"), true);

   }


   if ($("#curso_id").val().length == 0) {

    alerta_formulario($("#curso_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#curso_id"), true);

   }
   
   if ($("#tipo_documento_id").val().length == 0) {

    alerta_formulario($("#tipo_documento_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#tipo_documento_id"), true);

   }
   
   if ($("#documento_persona").val().length == 0) {

    alerta_formulario($("#documento_persona"), false);
    valido = false;

   } else {

    alerta_formulario($("#documento_persona"), true);

   }

   if ($("#nacionalidad_id").val().length == 0) {

    alerta_formulario($("#nacionalidad_id"), false);
    valido = false;

   } else {

    alerta_formulario($("#nacionalidad_id"), true);

   }


   if ($("#fecha_nacimiento").val().length == 0) {

    alerta_formulario($("#fecha_nacimiento"), false);
    valido = false;

   } else {

    alerta_formulario($("#fecha_nacimiento"), true);

   }



   if (valido) {

    var x = confirm("Está seguro de guardar ?");
    if (x)
     $("#form-matriculacion-superior").submit();

   }

  }

  if ($("#seccion").val() == '2') {

    var x = confirm("Está seguro de guardar ?");
    if (x)
     $("#form-matriculacion-superior").submit();


  }

  if ($("#seccion").val() == '3') {

   if ($("input:radio[name=discapacidad_id]").is(':checked')) {

    if ($("#discapacidad_id_147").is(':checked')) {

     if (!$("input:radio[name=auditiva_id]").is(':checked') && !$("input:radio[name=visual_id]").is(':checked') && !$("input:radio[name=psicosocial_id]").is(':checked') && !$("input:radio[name=intelectual_id]").is(':checked') && $("#fisica_descripcion").val().length == 0 && !$("#aprendizaje_lectoescritura_id_159").is(':checked') && !$("#aprendizaje_calculo_id_160").is(':checked') && !$("#aprendizaje_otro_id_161").is(':checked') && !$("#lenguaje_comprension_id_162").is(':checked') && !$("#lenguaje_expresion_id_163").is(':checked') && !$("#lenguaje_otro_id_164").is(':checked') && $("#otras_discapacidades").val().length == 0) {

      msg += "Especifique alguna discapacidad o trastorno.\n";
      valido = false;

     } else {

      if ($("#aprendizaje_otro_id_161").is(':checked') && $("#aprendizaje_otro").val().length == 0) {

       msg += "Especifique otro trastorno del aprendizaje.\n";
       valido = false;

      }

      if ($("#lenguaje_otro_id_164").is(':checked') && $("#lenguaje_otro").val().length == 0) {

       msg += "Especifique otro trastorno del lenguaje.\n";
       valido = false;

      }

     }

    }

    if ($("#con_diagnostico_id_166").is(':checked') && $("#diagnostico_descripcion").val().length == 0) {

     msg += "Especifique el diagnóstico médico.\n";
     valido = false;

    }

   } else {

    msg += "Seleccione si o no posee discapacidad.\n";
    valido = false;

   }


   if (valido) {

    var x = confirm("Está seguro de guardar ?");
    if (x)
     $("#form-matriculacion-superior").submit();

   } else {

    alert(msg);

   }

  }

  if ($("#seccion").val() == '4') {

    var x = confirm("Está seguro de guardar ?");
    if (x)
     $("#form-matriculacion-superior").submit();
    
  }

  if ($("#seccion").val() == '5') {

   if ($("#cantidad_personas_casa").val().length == 0) {

    alerta_formulario($("#cantidad_personas_casa"), false);
    valido = false;

   } else {

    alerta_formulario($("#cantidad_personas_casa"), true);

   }

   if ($("#cantidad_piezas_dormir").val().length == 0) {

    alerta_formulario($("#cantidad_piezas_dormir"), false);
    valido = false;

   } else {

    alerta_formulario($("#cantidad_piezas_dormir"), true);

   }

   if (valido) {

    var x = confirm("Está seguro de guardar ?");
    if (x)
     $("#form-matriculacion-superior").submit();

   }

  }

  if ($("#seccion").val() == '6') {

   if ($("input:radio[name=recibe_beneficio]").is(':checked')) {

    if ($("#recibe_beneficio_255").is(':checked')) {

     if (!$("#beneficio_id_257").is(':checked') && !$("#beneficio_id_258").is(':checked') && !$("#beneficio_id_259").is(':checked') && !$("#beneficio_id_260").is(':checked') && !$("#beneficio_id_261").is(':checked')) {

      msg += "Especifique algun beneficio.\n"
      valido = false;

     }

    }

   } else {

    msg += "Seleccione si o no recibe beneficio.\n";
    valido = false;

   }

   if (valido) {

    var x = confirm("Está seguro de guardar ?");
    if (x)
     $("#form-matriculacion-superior").submit();

   } else {

    alert(msg);

   }

  }


  return false;

 });
});
//----------------------------------------------------------------------//


//----------------------- ALERTA PARA FOMULARIOS ---------------//
function alerta_formulario(elemento, estado) {

 style = elemento.attr('style');

 if (estado) {

  elemento.attr("style", style + "border:1px solid green;");
  elemento.parent().next().html("<span class='glyphicon glyphicon-ok' style='color:green;padding-top:20px;'></span>");

 } else {

  elemento.attr("style", style + "border:1px solid red;");
  elemento.parent().next().html("<span class='glyphicon glyphicon-remove' style='color:red;padding-top:20px;'></span>");

 }

}
//--------------------------------------------------------------//


// --------------------- BUSCAR PERSONA ------------------------//
function buscar_persona(tipo_documento_id, nacionalidad_id, documento, ruta) {

 $("#msg-documento-persona").remove();

 $.ajax({
  type: 'GET',
  url: ruta,
  data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento: documento},
  success: function (data) {

   if (data != null) {

    $("#documento_persona").next();

    $("#nombre_persona").val(data.nombre_persona);
    $("#apellido_persona").val(data.apellido_persona);

   } else {


    $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Persona no encontrada. Envie una copia de su documento de identidad al correo rue@mec.gov.py para registrarla.</span>").insertAfter("#documento_persona");

    $("#nombre_persona").val('');
    $("#apellido_persona").val('');
    $("#fecha_nacimiento").val('');
    $("#genero_id").val('');

    if (tipo_documento_id == '1') {

     $("#nombre_persona").attr("readonly", true);
     $("#apellido_persona").attr("readonly", true);

    } else {

     $("#nombre_persona").attr("readonly", false);
     $("#apellido_persona").attr("readonly", false);

    }

   }
  },
  typeData: 'json'
 });
}
//--------------------------------------------------------------------//
// --------------------- BUSCAR PERSONA V2 ------------------------//
function buscar_persona_v2(tipo_documento_id, nacionalidad_id, documento, fecha_nacimiento, ruta) {

 $("#msg-documento-persona").remove();

 $.ajax({
  type: 'GET',
  url: ruta,
  data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento: documento, fecha_nacimiento: fecha_nacimiento},
  success: function (data) {

   if (data != null) {

    $("#documento_persona").next();

    $("#nombre_persona").val(data.nombre_persona);
    $("#apellido_persona").val(data.apellido_persona);
    $("#fecha_nacimiento").val(formatear_fecha(data.fecha_nacimiento));
    $("#genero_id").val(data.genero_id);
    $("#barrio_localidad").val(data.barrio_localidad);
    $("#direccion").val(data.direccion);
    $("#numero_casa").val(data.numero_casa);
    $("#numero_apartamento").val(data.numero_apartamento);
    $("#nombre_edificio").val(data.nombre_edificio);
    $("#departamento_id").focus();

   } else {


    $("<span id='msg-documento-persona' style='color:red;padding-top:20px;font-size:10px;'>Persona no encontrada. Envie una copia de su documento de identidad al correo rue@mec.gov.py para registrarla.</span>").insertAfter("#documento_persona");

    $("#nombre_persona").val('');
    $("#apellido_persona").val('');
    //$("#fecha_nacimiento").val('');
    $("#genero_id").val('');

    if (tipo_documento_id == '1') {

     $("#nombre_persona").attr("readonly", true);
     $("#apellido_persona").attr("readonly", true);

    } else {

     $("#nombre_persona").attr("readonly", false);
     $("#apellido_persona").attr("readonly", false);

    }

   }
  },
  typeData: 'json'
 })
}
//--------------------------------------------------------------------//
// --------------------- BUSCAR PERSONA PADRES ------------------------//
function buscar_persona_padres(tipo_documento_id, nacionalidad_id, documento, prefijo, ruta) {

 $("#msg-documento-persona-" + prefijo).remove();

 $.ajax({
  type: 'GET',
  url: ruta,
  data: {tipo_documento_id: tipo_documento_id, nacionalidad_id: nacionalidad_id, documento: documento},
  success: function (data) {

   if (data != null) {

    $("#nombre_" + prefijo).val(data.nombre_persona);
    $("#apellido_" + prefijo).val(data.apellido_persona);
    $("#fecha_nacimiento_" + prefijo).val(formatear_fecha(data.fecha_nacimiento));
    $("#genero_" + prefijo + "_id").val(data.genero_id);
    $("#telefono_" + prefijo).val(data.telefono);
    $("#celular_" + prefijo).val(data.celular);
    $("#correo_electronico_" + prefijo).val(data.correo_electronico);

    $("#telefono_" + prefijo).focus();

   } else {


    $("<span id='msg-documento-persona-" + prefijo + "' style='color:red;padding-top:20px;font-size:10px;'>Persona no encontrada. Envie una copia de su documento de identidad al correo rue@mec.gov.py para registrarla.</span>").insertAfter("#documento_" + prefijo);

    $("#nombre_" + prefijo).val('');
    $("#apellido_" + prefijo).val('');
    $("#fecha_nacimiento_" + prefijo).val('');
    $("#genero_" + prefijo + "_id").val('');
    $("#telefono_" + prefijo).val('');
    $("#celular_" + prefijo).val('');
    $("#correo_electronico_" + prefijo).val('');

   }
  },
  typeData: 'json'
 })
}
//--------------------------------------------------------//

