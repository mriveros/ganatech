module HaciendasHelper

  def link_to_editar_hacienda(hacienda)

      render partial: 'link_to_editar_hacienda', locals: { hacienda: hacienda }
      
  end

  def verificar_predeterminado(hacienda_id)

    @hacienda = Hacienda.where("id = ?", hacienda_id).first
    
      return @hacienda.predeterminado
   
  end
  
end
