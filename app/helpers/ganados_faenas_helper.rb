module GanadosFaenasHelper

  def link_to_ganado_faena_detalle(ganado_faena_id)

    render partial: 'link_to_ganado_faena_detalle', locals: { ganado_faena_id: ganado_faena_id}

  end

end