
function buscar_persona_v2(tipo_documento_id, nacionalidad_id, documento, ruta, ruta_agregar_persona){

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
      }else{


        $("<span id='msg-documento-persona' style='color:red;font-size:10px;margin: 10px 0 0 10px;'>Persona no encontrada.<a href='" + ruta_agregar_persona + "' class='btn btn-primary btn-xs' target='_blank' style='margin-left:10px;'>Agregar Persona</a></span>").insertAfter("#persona_documento");

        $("#persona_nombre").val('');
        $("#persona_apellido").val('');
      }
    },
    typeData: 'json'     
  })
}