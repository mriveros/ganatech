module GanadosEntradasHelper

	def link_to_editar_ganado_entrada(ganado_entrada_id)

	    render partial: 'link_to_editar_ganado_entrada', locals: { ganado_entrada_id: ganado_entrada_id }
	    
	end

	def link_to_cambiar_estado_entrada_ganado_a_finalizado(ganado_entrada_id)

		render partial: 'link_to_cambiar_estado_entrada_ganado_a_finalizado', locals:{ganado_entrada_id: ganado_entrada_id}

	end
  
end
