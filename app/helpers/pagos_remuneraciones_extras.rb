module PagosRemuneracionesExtrasHelper

	def link_to_editar_pago_remuneraciones_extras(pago_remuneracion_extra)

    	render partial: 'link_to_editar_pago_remuneraciones_extras', locals: { pago_remuneracion_extra: pago_remuneracion_extra }
    
	end

end