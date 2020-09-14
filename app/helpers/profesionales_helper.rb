module ProfesionalesHelper

  def link_to_editar_profesional(persona_id)

      render partial: 'link_to_editar_profesional', locals: { persona_id: persona_id }
      
  end

  def link_to_profesional_detalle_fono(profesional_id)

    render partial: 'link_to_profesional_detalle_fono', locals: { profesional_id: profesional_id}

  end
  
end