module PagosAdelantosHelper

	def link_to_editar_pago_adelanto(pago_adelanto)

    	render partial: 'link_to_editar_pago_adelanto', locals: { pago_adelanto: pago_adelanto }
    
	end

end