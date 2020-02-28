module DetallesCreditosHelper

	
	def link_to_editar_detalle_credito(detalle_credito)

    	render partial: 'link_to_editar_detalle_credito', locals: { detalle_credito: detalle_credito }
    
	end

end
