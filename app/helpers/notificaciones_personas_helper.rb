module NotificacionesPersonasHelper

  def link_to_editar_notificacion_persona(notificacion_persona)

      render partial: 'link_to_editar_notificacion_persona', locals: { notificacion_persona: notificacion_persona }
      
  end

  
end