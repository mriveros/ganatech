module CelosHelper

  def link_to_editar_celo(celo_id)

      render partial: 'link_to_editar_celo', locals: { celo_id: celo_id }
      
  end

  def link_to_celo_detalle(celo_id)

    render partial: 'link_to_celo_detalle', locals: { celo_id: celo_id}

  end

  def link_to_cambiar_estado_celo_a_fecundacion(celo_id)

    render partial: 'link_to_cambiar_estado_celo_a_fecundacion', locals: {celo_id: celo_id}

  end

  def link_to_cambiar_estado_a_en_reproduccion(celo_id)

    render partial: 'link_to_cambiar_estado_a_en_reproduccion', locals: {celo_id: celo_id}

  end


  def link_to_cambiar_estado_a_celo_perdido(celo_id)

    render partial: 'link_to_cambiar_estado_a_celo_perdido', locals: {celo_id: celo_id}

  end
  
end