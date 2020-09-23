class PagosRemuneracionesExtrasController < ApplicationController

	before_filter :require_usuario

	  def index


	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_pagos_remuneraciones_extras_id].present?

	      cond << "pago_remuneracion_extra_id = ?"
	      args << params[:form_buscar_pagos_remuneraciones_extras_id]

	    end

	    if params[:form_buscar_pagos_remuneraciones_extras_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_pagos_remuneraciones_extras_fecha]

	    end

	    if params[:form_buscar_pagos_remuneraciones_extras_nombre_personal].present?

	      cond << "personal_nombre ilike ?"
	      args << "%#{params[:form_buscar_pagos_remuneraciones_extras_nombre_personal]}%"

	    end

	    if params[:form_buscar_pagos_remuneraciones_extras_apellido_personal].present?

	      cond << "personal_apellido ilike ?"
	      args << "%#{params[:form_buscar_pagos_remuneraciones_extras_apellido_personal]}%"
 
	    end

	    if params[:form_buscar_pagos_remuneraciones_extras][:mes_periodo_id].present?

      		cond << "mes_periodo_id = ?"
      		args << params[:form_buscar_pagos_remuneraciones_extras][:mes_periodo_id]

    	end

    	if params[:form_buscar_pagos_remuneraciones_extras_anho_periodo].present?

	      cond << "anho_periodo ilike ?"
	      args << "%#{params[:form_buscar_pagos_remuneraciones_extras_anho_periodo]}%"

	    end
	    
	    if params[:form_buscar_pagos_remuneraciones_extras_monto].present?

	      cond << "monto = ?"
	      args << params[:form_buscar_pagos_remuneraciones_extras_monto]

	    end

	    if params[:form_buscar_pagos_remuneraciones_extras_observacion].present?

	      cond << "observacion ilike ?"
	      args << "%#{params[:form_buscar_pagos_remuneraciones_extras_observacion]}%"

	    end
	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @pagos_remuneraciones_extras =  VPagoRemuneracionExtra.orden_fecha_desc.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VPagoRemuneracionExtra.where(cond).count

	    else

	      @pagos_remuneraciones_extras = VPagoRemuneracionExtra.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = PagoRemuneracionExtra.count

	    end

	    @total_registros = RegistroGasto.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @pago_remuneracion_extra = PagoRemuneracionExtra.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    @valido = true
	    @msg = ""
	    
	    if @valido

		    @pago_remuneracion_extra = PagoRemuneracionExtra.new()
		    @pago_remuneracion_extra.fecha = params[:fecha]
		    @pago_remuneracion_extra.personal_id = params[:personal][:id]
		    @pago_remuneracion_extra.mes_periodo_id = params[:mes_periodo][:id]
		    @pago_remuneracion_extra.anho_periodo = params[:anho_periodo]
		    @pago_remuneracion_extra.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
		    @pago_remuneracion_extra.observacion = params[:observacion]

		    if @pago_remuneracion_extra.save

		    	auditoria_nueva("Registrar nuevo RemuneracionExtra", "pagos_remuneraciones_extras", @pago_remuneracion_extra)
		        @guardado_ok = true
		       
		    end 

		 end
	         
	    respond_to do |f|

	      f.js

	    end

	  end

	  def eliminar

	    @valido = true
	    @msg = ""
	    @eliminado =false

	    @pago_remuneracion_extra = PagoRemuneracionExtra.find(params[:id])
	    @pago_remuneracion_extra_elim = @pago_remuneracion_extra

	    if @valido

	      if @pago_remuneracion_extra.destroy

	        auditoria_nueva("Eliminar registro de RemuneracionExtra", "pagos_remuneraciones_extras", @pago_remuneracion_extra_elim)
	        @eliminado = true

	      end

	    end
	        
	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @pago_remuneracion_extra = PagoRemuneracionExtra.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @pago_remuneracion_extra = PagoRemuneracionExtra.find(params[:pago_remuneracion_extra_id])
	    auditoria_id = auditoria_antes("actualizar pago_remuneracion_extra", "pagos_remuneraciones_extras", @pago_remuneracion_extra)

	    if valido

	    	
		    @pago_remuneracion_extra.fecha = params[:pago_remuneracion_extra][:fecha]
		    @pago_remuneracion_extra.personal_id = params[:pago_remuneracion_extra][:personal_id]
		    @pago_remuneracion_extra.mes_periodo_id = params[:pago_remuneracion_extra][:mes_periodo_id]
		    @pago_remuneracion_extra.anho_periodo = params[:pago_remuneracion_extra][:anho_periodo]
		    @pago_remuneracion_extra.monto = params[:pago_remuneracion_extra][:monto].to_s.gsub(/[$.]/,'').to_i
		    @pago_remuneracion_extra.observacion = params[:pago_remuneracion_extra][:observacion]

		    if @pago_remuneracion_extra.save

		    	auditoria_nueva("Registrar nuevo Remuneracion Extra", "pagos_remuneraciones_extras", @pago_remuneracion_extra)
		        @actualizado_ok = true
		       
		    end 

		 end
	         
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end