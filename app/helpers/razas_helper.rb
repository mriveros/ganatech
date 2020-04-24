module RazasHelper

  def link_to_editar_raza(raza)

      render partial: 'link_to_editar_raza', locals: { raza: raza }
      
  end
  
end