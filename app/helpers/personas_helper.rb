module PersonasHelper

  def link_to_editar_persona(persona)
    render partial: 'link_to_editar_persona', locals: { persona: persona }
  end
  
   def link_to_unificar_persona(persona)
    render partial: 'link_to_unificar_persona', locals: { persona: persona }
  end

end
