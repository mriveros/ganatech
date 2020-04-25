module HaciendasHelper

  def link_to_editar_hacienda(hacienda)

      render partial: 'link_to_editar_hacienda', locals: { hacienda: hacienda }
      
  end

  def link_to_hacienda_detalle(hacienda_id)

      render partial: 'link_to_hacienda_detalle', locals: { hacienda_id: hacienda_id }
      
  end

  def verificar_predeterminado(hacienda_id)

    @hacienda = Hacienda.where("id = ?", hacienda_id).first
    
      return @hacienda.predeterminado
   
  end
  
end
