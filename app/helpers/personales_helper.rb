module PersonalesHelper

  def link_to_editar_personal(personal)

      render partial: 'link_to_editar_personal', locals: { personal: personal }
      
  end

  def link_to_personal_detalle(personal_id)

    render partial: 'link_to_personal_detalle', locals: { personal_id: personal_id}

  end
  
end