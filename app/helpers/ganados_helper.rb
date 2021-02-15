module GanadosHelper

  def link_to_editar_ganado(ganado_id)

      render partial: 'link_to_editar_ganado', locals: { ganado_id: ganado_id }
      
  end

  def link_to_ganado_detalle(ganado_id)

    render partial: 'link_to_ganado_detalle', locals: { ganado_id: ganado_id}

  end

  def link_to_adjuntar_archivo_sanidad(control_ganado_id)

    render partial: 'link_to_adjuntar_archivo_sanidad', locals: { control_ganado_id: control_ganado_id}

  end
  
end