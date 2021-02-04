module MedicamentosHelper

	def link_to_medicamento_detalle(medicamento_id)

	    render partial: 'link_to_medicamento_detalle', locals: { medicamento_id: medicamento_id }
	    
	end


	def link_to_editar_medicamento(medicamento_id)

	  render partial: 'link_to_editar_medicamento', locals: {medicamento_id: medicamento_id}

	end

	def link_to_dar_baja_medicamento(medicamento_id)

	  render partial: 'link_to_dar_baja_medicamento', locals: {medicamento_id: medicamento_id}

	end
  
end
