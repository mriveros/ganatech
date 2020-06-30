module AlimentacionesHelper

def link_to_alimentacion_detalle(alimentacion_id)

    render partial: 'link_to_alimentacion_detalle', locals: { alimentacion_id: alimentacion_id }

end


def link_to_editar_alimentacion(alimentacion_id)

  render partial: 'link_to_editar_alimentacion', locals: {alimentacion_id: alimentacion_id}

end

end
