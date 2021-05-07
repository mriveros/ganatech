module PotrerosHelper

  def link_to_editar_potrero(potrero_id)

      render partial: 'link_to_editar_potrero', locals: { potrero_id: potrero_id }
      
  end

  def link_to_potrero_detalle(potrero_id)

    render partial: 'link_to_potrero_detalle', locals: { potrero_id: potrero_id}

  end

  def link_to_potrero_geocerca(potrero_id)

    render partial: 'link_to_potrero_geocerca', locals: { potrero_id: potrero_id}

  end
  
end