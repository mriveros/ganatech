module TutoresHelper

  def link_to_editar_tutor(persona_id)

      render partial: 'link_to_editar_tutor', locals: { persona_id: persona_id }
      
  end

  def link_to_tutor_detalle(tutor_id)

    render partial: 'link_to_tutor_detalle', locals: { tutor_id: tutor_id}

  end
  
end