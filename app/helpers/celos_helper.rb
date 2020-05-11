module CelosHelper

  def link_to_editar_celo(celo_id)

      render partial: 'link_to_editar_celo', locals: { celo_id: celo_id }
      
  end

  def link_to_celo_detalle(celo_id)

    render partial: 'link_to_celo_detalle', locals: { celo_id: celo_id}

  end
  
end