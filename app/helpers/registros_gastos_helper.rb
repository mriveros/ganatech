module RegistrosGastosHelper

	def link_to_editar_registro_gasto(registro_gasto)

    	render partial: 'link_to_editar_registro_gasto', locals: { registro_gasto: registro_gasto }
    
	end


end
