module CargosHelper

  def link_to_editar_cargo(cargo)

      render partial: 'link_to_editar_cargo', locals: { cargo: cargo }
      
  end

  
end