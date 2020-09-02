module AltasProduccionesQuesosHelper

	def link_to_alta_produccion_detalle(alta_produccion_id)

      render partial: 'link_to_alta_produccion_detalle', locals: { alta_produccion_id: alta_produccion_id }
      
  	end

  	def link_to_editar_alta_produccion(alta_produccion_id)

      render partial: 'link_to_editar_alta_produccion', locals: { alta_produccion_id: alta_produccion_id }
      
  	end

  	def verificar_produccion_lote(alta_produccion_detalle_id)

      lote_produccion_ganado = LoteProduccionGanado.where("alta_produccion_detalle_id = ?", alta_produccion_detalle_id).first
      return (lote_produccion_ganado.present?)? true : false
      
  	end
  
end