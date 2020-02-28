module ProduccionHelper

	def link_to_produccion_detalle_credito(produccion)

    	render partial: 'link_to_produccion_detalle_credito', locals: { produccion: produccion }
    
	end

	def link_to_produccion_detalle_debito(produccion)

    	render partial: 'link_to_produccion_detalle_debito', locals: { produccion: produccion }
    
	end

	def link_to_produccion_planilla_resumen_produccion(produccion )
   
    	render :partial => 'link_to_produccion_planilla_resumen_produccion', :locals => { :produccion => produccion}
  
  end

  def link_to_produccion_planilla_resumen_produccion_cliente(produccion )
   
      render :partial => 'link_to_produccion_planilla_resumen_produccion_cliente', :locals => { :produccion => produccion}
  
  end

end
