module GanadosSalidasHelper

	def link_to_editar_ganado_salida(ganado_salida_id)

	    render partial: 'link_to_editar_ganado_salida', locals: { ganado_salida_id: ganado_salida_id }
	    
	end

	def link_to_cambiar_estado_salida_ganado_a_finalizado(ganado_salida_id)

		render partial: 'link_to_cambiar_estado_entrada_ganado_a_finalizado', locals:{ganado_salida_id: ganado_salida_id}

	end

	def verificar_ganado_lote(ganado_id)

      lote_control_ganado = LoteControlGanado.where("ganado_id = ?", ganado_id).first
      return (lote_control_ganado.present?)? true : false
      
  end
  
end
