module AltasProduccionesHelper

	def link_to_alta_produccion_detalle(alta_produccion_id)

      render partial: 'link_to_alta_produccion_detalle', locals: { alta_produccion_id: alta_produccion_id }
      
  end

  def link_to_editar_alta_produccion(alta_produccion_id)

      render partial: 'link_to_editar_alta_produccion', locals: { alta_produccion_id: alta_produccion_id }
      
  end

  
  
end
