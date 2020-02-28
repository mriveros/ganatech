module UsuariosHelper

  def link_to_editar_usuario(usuario)
    render partial: 'link_to_editar_usuario', locals: { usuario: usuario }
  end

  def link_to_perfiles(usuario)

    render partial: "link_to_perfiles", locals: { usuario: usuario}

  end

  def link_to_reset_password(usuario)
    render partial: 'link_to_reset_password', locals: { usuario: usuario }
  end

end
