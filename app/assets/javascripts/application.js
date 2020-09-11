// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery.ui.autocomplete
//= require underscore
//= stub leaflet
//= stub bootstrap-slider
//= stub gmaps/gmaps.js
//= stub gmaps/markerclusterer.js
//= require index_view.js
//= require firsttime.js
//= require intro.min.js
//= require rue_plugins.js
//= require master_detail.js
//= require bootstrap-datepicker.js
//= require bootstrap-datepicker.es.js
//= require Chart.bundle
//= require chartkick

/*Funcion que limpia el formulario del Dataset*/
function resetForm(formId, valor_defecto) {

    var form = $(formId);
    form.find('input:text, input:password, input:file, select, textarea').val('');
    form.find('input:radio, input:checkbox')
            .removeAttr('checked').removeAttr('selected');

    if (valor_defecto !== "CONTACTOS") {
        if (valor_defecto !== null) {
            $.each(valor_defecto, function(idx, v) {
                $(v.id).val(v.valor);
            });
        }
        $.ajaxQ.abortAll();
        form.submit();
    } else {
        //nothing to do
    }
}
/*Funcion que quita el filtro seleccionado*/
function quitar_filtro(formId, id, valor_defecto) {
    var form = $(formId);
    if (typeof (valor_defecto) !== "undefined") {
        $(id).val(valor_defecto);
    } else {
        $(id).val('');
    }
    $.ajaxQ.abortAll();
    form.submit();
}

$.ajaxQ = (function() {

    var id = 0, Q = {};

    $(document).ajaxSend(function(e, jqx) {
        jqx._id = ++id;
        Q[jqx._id] = jqx;
    });
    $(document).ajaxComplete(function(e, jqx) {
        delete Q[jqx._id];
    });

    return {
        abortAll: function() {
            var r = [];
            $.each(Q, function(i, jqx) {
                r.push(jqx._id);
                jqx.abort();
            });
            return r;
        }
    };

})();
$(function() {
    tour();
    listados();
});
function tour() {
    if ($('#start-tour').length) {
        if ($.cookie('firstVisit') === undefined) {
            $.cookie('firstVisit', 'true');
            var date = new Date();
            var m = 1;
            date.setTime(date.getTime() + (m * 60 * 1000));
            $.cookie("firstVisit", "value", {expires: date});
        } else {
            $.cookie('firstVisit', 'false');
        }
        var firstVisit = $.cookie('firstVisit');
        if (firstVisit === 'true') {
            introJs().setOptions({
                doneLabel: 'Salir',
                nextLabel: 'Siguiente &rarr;',
                prevLabel: '&larr; Anterior',
                skipLabel: 'Salir',
                steps: stepsListado
            }).start();
        } else {
            //nothing to do
        }
    } else {
        //nothing to do
    }
}
;
function listados() {
    window.redimensionar = function() {

        $('.descripcion-oculta').each(function(d, descripcion) {
            $(descripcion).addClass('hidden-xs').show();
        });

        $('.listado li').each(function(f, fila) {
            $(fila).css('height', 'auto');
            $(fila).css('height', $(fila).height());
        });

    };
    $('body').attr('onresize', 'redimensionar();');
    window.redimensionar();
}
;

function aplicar_datepicker(){

  $('.input-group.date').datepicker({

    format: "yyyy-mm-dd",
    language: "es",
    calendarWeeks: true,
    todayHighlight: true,
    autoclose: true
 
  });

}

function aplicar_datepicker2(){

  $('.input-group.date').datepicker({

    format: "dd/mm/yyyy",
    language: "es",
    //calendarWeeks: true,
    todayHighlight: true,
    showOnFocus: false,
    autoclose: true
 
  });

}

function formatear_fecha(fecha){

  if(fecha.length > 0){
 
    fecha = fecha.substring(8,10)+"/"+fecha.substring(5,7)+"/"+fecha.substring(0,4)
    
  }

  return fecha;
}

function formatear_numero(objeto) {

    //Muestra mensaje de diferencias entre lo informado y depositado
    
    var valor = "";
    var auxi = "";
    var val2 = "";

    valor = objeto.value;
    valor = valor.toString().trim();
    val2 = valor;
    valor = valor.split(".");

    var ultimo = valor.pop();

    if (ultimo == '000') {
        var number = parseInt(objeto.value);
    } else {
        auxi = val2.split(".").join("");
        var number = parseInt(auxi);
    }
    
    if (isNaN(number) == true) {
        number = 0
    }
    
    console.log("Función en js: formatear_numero ***");
    console.log(number.toLocaleString('es-PY'));
    if (number.toLocaleString('es-PY') === "NaN") {
        objeto.value = null;
    } else {
        objeto.value = number.toLocaleString('es-PY');
    }
   
    console.log("Función en js: formatear_numero 2 ***");
    console.log(number.toLocaleString('es-PY'));
}
