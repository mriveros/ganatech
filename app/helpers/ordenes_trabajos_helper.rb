module OrdenesTrabajosHelper

  def link_to_orden_trabajo_detalle(orden_trabajo_id)

    render partial: 'link_to_orden_trabajo_detalle', locals: { orden_trabajo_id: orden_trabajo_id }

  end


  def link_to_editar_orden_trabajo(orden_trabajo_id)

    render partial: 'link_to_editar_orden_trabajo', locals: {orden_trabajo_id: orden_trabajo_id}

  end

end