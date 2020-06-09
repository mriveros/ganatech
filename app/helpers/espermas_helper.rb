module EspermasHelper

  def link_to_editar_esperma(esperma_id)

      render partial: 'link_to_editar_esperma', locals: { esperma_id: esperma_id }
      
  end

  def link_to_esperma_detalle(esperma_id)

    render partial: 'link_to_esperma_detalle', locals: { esperma_id: esperma_id}

  end
  
end