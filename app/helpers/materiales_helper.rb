module MaterialesHelper

	def link_to_editar_material(material)

    	render partial: 'link_to_editar_material', locals: { material: material }
    
	end


end
