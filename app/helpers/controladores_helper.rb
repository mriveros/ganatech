module ControladoresHelper

  def link_to_editar_controlador(controlador)
    
    render :partial => 'link_to_editar_controlador', :locals => { :controlador => controlador}

  end

  def link_to_acciones_lista(controlador_id)
    
    render :partial => 'link_to_acciones_lista', :locals => { :controlador_id => controlador_id}

  end

  def link_to_acciones(controlador)

    render partial: "link_to_acciones", locals: { controlador: controlador}

  end

end
