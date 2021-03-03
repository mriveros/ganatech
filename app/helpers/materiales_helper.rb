module MaterialesHelper

	def link_to_editar_material(material_id)

    	render partial: 'link_to_editar_material', locals: { material_id: material_id }
    
	end


	def link_to_material_detalle(material_id)

    	render partial: 'link_to_material_detalle', locals: { material_id: material_id }
    
	end


end
