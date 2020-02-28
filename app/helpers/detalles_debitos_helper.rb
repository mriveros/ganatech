module DetallesDebitosHelper

	def link_to_editar_detalle_debito(detalle_debito)

    	render partial: 'link_to_editar_detalle_debito', locals: { detalle_debito: detalle_debito }
    
	end


end
