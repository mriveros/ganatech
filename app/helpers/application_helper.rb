module ApplicationHelper

  def notificaciones
  
    html = "<div style='clear:both;'></div>"

    if flash[:notice].present?
      html += "<div class='alert alert-success' role='alert' style='width:98%;margin-left:15px;'>#{flash[:notice]}</div>"
    end

    if flash[:error].present?
      html += "<div class='alert alert-danger' role='alert' style='width:98%;margin-left:15px;'>#{flash[:error]}</div>"
    end

    html.html_safe

  end

  def obtener_mes(mes)

    case mes
    when 1 then "enero"
    when 2 then "febrero"
    when 3 then "marzo"
    when 4 then "abril"
    when 5 then "mayo"
    when 6 then "junio"
    when 7 then "julio"
    when 8 then "agosto"
    when 9 then "setiembre"
    when 10 then "octubre"
    when 11 then "noviembre"
    when 12 then "diciembre"
    else ""
    end

  end

  def icon_delete
    image_tag("delete-icon.png", :style => "width:16px;")
  end
  
  def options_meses
    
    [["",""],["enero", 1],["febrero", 2],["marzo", 3], ["abril", 4], ["mayo", 5], ["junio", 6], ["julio", 7], ["agosto", 8], ["setiembre", 9], ["octubre", 10], ["novimiembre", 11], ["diciembre", 12]]

  end

  def modal_window(args)

    render :partial => "helpers/modal_window", locals: { window_id: args[:window_id], link_to_id: args[:link_to_id], url: args[:url]}

  end

    #CONTROL DE ACCESO
  def acceso_permitido(acceso)

    permitido = VAcceso.where("usuario_id = ? and acceso = ? and sistema_id = ?", current_usuario.id, acceso, VAcceso::SISTEMA_ID)
    permitido.present?

  end
  #FIN CONTROL DE ACCESOS

  def icon_borrar
    "<i class='glyphicon glyphicon-remove' style='color:#F50A19;size:12px'></i>".html_safe
  end
  def image_del
    image_tag("delete-icon.png", :style => "width:16px;")
  end

  def icon_eliminar
    "<span class='glyphicon glyphicon-remove'></span>".html_safe
  end

  def icon_editar
    "<span class='glyphicon glyphicon-pencil'></span>".html_safe
  end

  def icon_usuario
    "<span class='glyphicon glyphicon-user'></span>".html_safe
  end
  
  def icon_user
      "<span class='glyphicon glyphicon-user'></span>".html_safe
    end

  def icon_detalles
    "<span class='glyphicon glyphicon-th-list'></span>".html_safe
  end

  def icon_detalles_adelanto
    "<span class='glyphicon glyphicon-th-list'>Adelantos</span>".html_safe
  end

  def icon_detalles_gasto
    "<span class='glyphicon glyphicon-th-list'>Gastos</span>".html_safe
  end

  def icon_mapas
    "<span class='glyphicon glyphicon-map-marker'></span>".html_safe
  end

  def icon_guardar
    "<span class='glyphicon glyphicon-floppy-disk'></span>".html_safe
  end

  def icon_volver
    "<span class='glyphicon glyphicon-chevron-left'></span>".html_safe
  end

  def icon_confirmar
      "<span class='glyphicon glyphicon-ok'></span>".html_safe
  end

  def icon_produccion
      "<span class='glyphicon glyphicon-ok'>alta producción</span>".html_safe
  end

  def icon_confirmar_cobro
      "<span class='glyphicon glyphicon-ok'>Cobrado</span>".html_safe
  end

  def icon_desconfirmar_cobro
      "<span class='glyphicon glyphicon-off'>No Cobrado</span>".html_safe
  end

  def icon_confirmar_finalizar
      "<span class='glyphicon glyphicon-ok'>Finalizar</span>".html_safe
  end

  def icon_confirmar_aprobar
      "<span class='glyphicon glyphicon-ok'>Aprobar</span>".html_safe
  end

  def icon_salud
     " <span class='glyphicon glyphicon-header'></span>".html_safe
  end
  
  def icon_rellenar
     " <span class='glyphicon glyphicon-sort-by-order'></span>".html_safe
  end

  def icon_perdido
     " <span class='glyphicon glyphicon-minus'></span>".html_safe
  end

  def icon_fecundacion
     " <span class='glyphicon glyphicon-plus'></span>".html_safe
  end

  def icon_reproduccion
     " <span class='glyphicon glyphicon-plus'></span>".html_safe
  end

  def icon_ok_sign
    "<span class='glyphicon glyphicon-ok-sign'></span>".html_safe
  end

  def icon_minus_sign
    "<span class='glyphicon glyphicon-minus-sign'></span>".html_safe
  end

  def linked_combo(nombre, args)
    args[:url] ||= ""
    args[:display] ||= "descripcion"
    args[:value] ||= "id"
    
    if args[:clase] == 'modalidad_nivel'

      args[:prompt] ||= "-- Sin modalidad --"

    else

      args[:prompt] ||= "-- Seleccione --"

    end

    args[:extra] ||= ""
    args[:extra1] ||= ""
    args[:selected] ||= "null"
    args[:js_selected] ||= "null"

    render :partial => "helpers/combo", :locals => {
      :nombre => nombre,
      :display => args[:display],
      :value => args[:value],
      :extra => args[:extra],
      :extra1 => args[:extra1],
      :url => args[:url],
      :prompt => args[:prompt],
      :linked => args[:linked],
      :param => args[:param],
      :clase=> args[:clase],
      :selected => args[:selected],
      :js_selected => args[:js_selected]
    }
  end
  

  def options_periodos
    periodos = []

    Time.now.year.downto(1900) do |i|
      periodos << [i,i]
    end
    periodos
  end  

  def options_periodos_matriculas
    periodos = []

    Time.now.year.downto(2016) do |i|
      periodos << [i]
    end
    periodos
  end 
  def options_periodos_impresion_titulos
    periodos = []

    Time.now.year.downto(2017) do |i|
      periodos << [i]
    end
    periodos
  end 
  def options_periodos_escolar
    periodos = []

    Time.now.year.upto(2018) do |i|
      periodos << [i]
    end
    periodos
  end 

  def attr_requerido

    " <span style='color:red;'>(*)</span>"

  end

  def current_usuario_perfiles

    Perfil.where("usuario_id = ? and id <> ? and exists (select * from roles where perfiles.rol_id = roles.id and roles.sistema_id = ? )", current_usuario.id, current_usuario.perfil_actual_id, VAcceso::SISTEMA_ID)

  end
  def options_periodos_variables
    periodos = []

    Time.now.year.downto(2016) do |i|
      periodos << [i]
    end
    periodos
  end 

  def verificacion_oferta_piloto(usuario_id)
    
      @ofertas_educativas_ids = UsuarioOfertaEducativa.where("usuario_id = ?", current_usuario.id).map(&:oferta_educativa_id)
      @oferta_piloto = AuxMaterialEducativoPiloto.where("oferta_educativa_id in (?)", @ofertas_educativas_ids)
      return @oferta_piloto.present?
          
  end

end