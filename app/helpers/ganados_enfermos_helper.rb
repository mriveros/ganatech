module GanadosEnfermosHelper

  def link_to_editar_ganado_enfermo(ganado_enfermo_id)

      render partial: 'link_to_editar_ganado_enfermo', locals: { ganado_enfermo_id: ganado_enfermo_id }
      
  end

  def link_to_ganado_enfermo_detalle(ganado_enfermo)

    render partial: 'link_to_ganado_enfermo_detalle', locals: { ganado_enfermo: ganado_enfermo}

  end

  def link_to_adjuntar_archivo(control_ganado_id)

    render partial: 'link_to_adjuntar_archivo', locals: { control_ganado_id: control_ganado_id}

  end
  
end