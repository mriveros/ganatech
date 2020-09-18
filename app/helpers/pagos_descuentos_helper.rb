module PagosDescuentosHelper

	def link_to_editar_pago_descuento(pago_descuento)

    	render partial: 'link_to_editar_pago_descuento', locals: { pago_descuento: pago_descuento }
    
	end

end