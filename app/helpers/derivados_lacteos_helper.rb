module DerivadosLacteosHelper

	def link_to_derivado_lacteo_detalle(derivado_lacteo_id)

      render partial: 'link_to_derivado_lacteo_detalle', locals: { derivado_lacteo_id: derivado_lacteo_id }
      
  	end

end