module PotrerosHelper

  def link_to_editar_potrero(potrero_id)

      render partial: 'link_to_editar_potrero', locals: { persona_id: persona_id }
      
  end

  def link_to_potrero_detalle(potrero_id)

    render partial: 'link_to_potrero_detalle', locals: { potrero_id: potrero_id}

  end
  
end