module PreciosHelper

  def link_to_editar_precio(precio)

      render partial: 'link_to_editar_precio', locals: { precio: precio }
      
  end

  def verificar_predeterminado(precio_id)

    @precio = Precio.where("id = ?", precio_id).first
    
    
      return @precio.predeterminado

   
  end
  
end
