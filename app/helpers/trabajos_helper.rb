module TrabajosHelper

  def link_to_editar_trabajo(trabajo)

      render partial: 'link_to_editar_trabajo', locals: { trabajo: trabajo }

  end

end