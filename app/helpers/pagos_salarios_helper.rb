module PagosSalariosHelper

	def link_to_editar_pago_salario(pago_salario)

    	render partial: 'link_to_editar_pago_salario', locals: { pago_salario: pago_salario }
    
	end


end
