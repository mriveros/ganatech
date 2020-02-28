module InformacionesHelper

  def link_to_editar_informacion(usuario)
    render partial: 'link_to_editar_informacion', locals: { usuario: usuario }
  end
	
  def link_to_editar_enlace(usuario)
    render partial: 'link_to_editar_enlace', locals: { usuario: usuario }
  end

  def link_to_perfiles(usuario)

    render partial: "link_to_perfiles", locals: { usuario: usuario}

  end
	
	def link_to_enlaces(usuario)

    render partial: "link_to_enlaces", locals: { usuario: usuario}

  end

 

end
