module ReproduccionesHelper

  def link_to_editar_reproduccion(reproduccion_id)

      render partial: 'link_to_editar_reproduccion', locals: { reproduccion_id: reproduccion_id }
      
  end

  def link_to_reproduccion_detalle(reproduccion_id)

    render partial: 'link_to_reproduccion_detalle', locals: { reproduccion_id: reproduccion_id}

  end

  def link_to_cambiar_estado_reproduccion_a_reproduccion_prenhada(reproduccion_id)

    render partial: 'link_to_cambiar_estado_reproduccion_a_reproduccion_prenhada', locals: {reproduccion_id: reproduccion_id}

  end

  def link_to_cambiar_estado_reproduccion_a_reproduccion_finalizada(reproduccion_id)

    render partial: 'link_to_cambiar_estado_reproduccion_a_reproduccion_finalizada', locals: {reproduccion_id: reproduccion_id}

  end


  def link_to_cambiar_estado_reproduccion_a_reproduccion_perdido(reproduccion_id)

    render partial: 'link_to_cambiar_estado_reproduccion_a_reproduccion_perdido', locals: {reproduccion_id: reproduccion_id}

  end
  
end