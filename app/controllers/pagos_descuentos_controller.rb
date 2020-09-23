class PagosDescuentosController < ApplicationController

	before_filter :require_usuario

	  def index

 
	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_pagos_descuentos_id].present?

	      cond << "pago_descuento_id = ?"
	      args << params[:form_buscar_pagos_descuentos_id]

	    end

	    if params[:form_buscar_pagos_descuentos_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_pagos_descuentos_fecha]

	    end

	    if params[:form_buscar_pagos_descuentos_nombre_personal].present?

	      cond << "personal_nombre ilike ?"
	      args << "%#{params[:form_buscar_pagos_descuentos_nombre_personal]}%"

	    end

	    if params[:form_buscar_pagos_descuentos_apellido_personal].present?

	      cond << "personal_apellido ilike ?"
	      args << "%#{params[:form_buscar_pagos_descuentos_apellido_personal]}%"
 
	    end

	    if params[:form_buscar_pagos_descuentos][:mes_periodo_id].present?

      		
      		cond << "mes_periodo_id = ?"
      		args << params[:form_buscar_pagos_descuentos][:mes_periodo_id]

    	end

    	if params[:form_buscar_pagos_descuentos_anho_periodo].present?

	      cond << "anho_periodo ilike ?"
	      args << "%#{params[:form_buscar_pagos_descuentos_anho_periodo]}%"

	    end
	    
	    if params[:form_buscar_pagos_descuentos_monto].present?

	      cond << "monto = ?"
	      args << params[:form_buscar_pagos_descuentos_monto]

	    end

	    if params[:form_buscar_pagos_descuentos_observacion].present?

	      cond << "observacion ilike ?"
	      args << "%#{params[:form_buscar_pagos_descuentos_observacion]}%"

	    end
	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @pagos_descuentos =  VPagoDescuento.orden_fecha_desc.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VPagoDescuento.where(cond).count

	    else

	      @pagos_descuentos = VPagoDescuento.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = PagoDescuento.count

	    end

	    @total_registros = RegistroGasto.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @pago_descuento = PagoDescuento.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    @valido = true
	    @msg = ""
	    
	    if @valido

		    @pago_descuento = PagoDescuento.new()
		    @pago_descuento.fecha = params[:fecha]
		    @pago_descuento.personal_id = params[:personal][:id]
		    @pago_descuento.mes_periodo_id = params[:mes_periodo][:id]
		    @pago_descuento.anho_periodo = params[:anho_periodo]
		    @pago_descuento.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
		    @pago_descuento.observacion = params[:observacion]

		    if @pago_descuento.save

		    	auditoria_nueva("Registrar nuevo descuento", "pagos_descuentos", @pago_descuento)
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

	    @pago_descuento = PagoDescuento.find(params[:id])
	    @pago_descuento_elim = @pago_descuento

	    if @valido

	      if @pago_descuento.destroy

	        auditoria_nueva("Eliminar registro de descuento", "pagos_descuentos", @pago_descuento_elim)
	        @eliminado = true

	      end

	    end
	        
	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @pago_descuento = PagoDescuento.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @pago_descuento = PagoDescuento.find(params[:pago_descuento_id])
	    auditoria_id = auditoria_antes("actualizar pago_descuento", "pagos_descuentos", @pago_descuento)

	    if valido

	    	
		    @pago_descuento.fecha = params[:pago_descuento][:fecha]
		    @pago_descuento.personal_id = params[:pago_descuento][:personal_id]
		    @pago_descuento.mes_periodo_id = params[:pago_descuento][:mes_periodo_id]
		    @pago_descuento.anho_periodo = params[:pago_descuento][:anho_periodo]
		    @pago_descuento.monto = params[:pago_descuento][:monto].to_s.gsub(/[$.]/,'').to_i
		    @pago_descuento.observacion = params[:pago_descuento][:observacion]

		    if @pago_descuento.save

		    	auditoria_nueva("Registrar nuevo descuento", "pagos_descuentos", @pago_descuento)
		        @actualizado_ok = true
		       
		    end 

		 end
	         
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end