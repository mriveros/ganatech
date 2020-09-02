module AltasProduccionesQuesosHelper

	def link_to_alta_produccion_queso_detalle(alta_produccion_queso_id)

      render partial: 'link_to_alta_produccion_queso_detalle', locals: { alta_produccion_queso_id: alta_produccion_queso_id }
      
  	end

end