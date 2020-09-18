module PagoSalarioHelper

	def link_to_salario_detalle(pago_salario_id)

      render partial: 'link_to_salario_detalle', locals: { pago_salario_id: pago_salario_id }
      
  	end

end