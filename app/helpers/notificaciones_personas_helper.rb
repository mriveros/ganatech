module NotificacionesPersonasHelper

  def link_to_editar_notificacion_persona(notificacion_usuario)

      render partial: 'link_to_editar_notificacion_usuario', locals: { notificacion_usuario: notificacion_usuario }
      
  end

  
end