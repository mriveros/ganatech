class PagosAdelantosController < ApplicationController

	before_filter :require_usuario

	  def index


	  end 

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_pagos_adelantos_id].present?

	      cond << "pago_adelanto_id = ?"
	      args << params[:form_buscar_pagos_adelantos_id]

	    end

	    if params[:form_buscar_pagos_adelantos_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_pagos_adelantos_fecha]

	    end

	    if params[:form_buscar_pagos_adelantos_nombre_personal].present?

	      cond << "personal_nombre ilike ?"
	      args << "%#{params[:form_buscar_pagos_adelantos_nombre_personal]}%"

	    end

	    if params[:form_buscar_pagos_adelantos_apellido_personal].present?

	      cond << "personal_apellido ilike ?"
	      args << "%#{params[:form_buscar_pagos_adelantos_apellido_personal]}%"
 
	    end

	    if params[:form_buscar_pagos_adelantos][:mes_periodo].present?

      		@mes_periodo = Mes.where("id = ?", params[:form_buscar_pagos_adelantos][:mes_periodo]).first
      		cond << "mes_periodo = ?"
      		args << @mes_periodo.descripcion

    	end

    	if params[:form_buscar_pagos_adelantos_anho_periodo].present?

	      cond << "anho_periodo ilike ?"
	      args << "%#{params[:form_buscar_pagos_adelantos_anho_periodo]}%"

	    end
	    
	    if params[:form_buscar_pagos_adelantos_monto].present?

	      cond << "monto = ?"
	      args << params[:form_buscar_pagos_adelantos_monto]

	    end

	    if params[:form_buscar_pagos_adelantos_observacion].present?

	      cond << "observacion ilike ?"
	      args << "%#{params[:form_buscar_pagos_adelantos_observacion]}%"

	    end
	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @pagos_adelantos =  VPagoAdelanto.orden_fecha_desc.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VPagoAdelanto.where(cond).count

	    else

	      @pagos_adelantos = VPagoAdelanto.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = PagoAdelanto.count

	    end

	    @total_registros = RegistroGasto.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @pago_adelanto = PagoAdelanto.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    @valido = true
	    @msg = ""
	    mes = Mes.where("id = ?", params[:mes_periodo][:id]).first
	    if @valido

		    @pago_adelanto = PagoAdelanto.new()
		    @pago_adelanto.fecha = params[:fecha]
		    @pago_adelanto.personal_id = params[:personal][:id]
		    @pago_adelanto.mes_periodo = mes.descripcion
		    @pago_adelanto.anho_periodo = params[:anho_periodo]
		    @pago_adelanto.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
		    @pago_adelanto.observacion = params[:observacion]

		    if @pago_adelanto.save

		    	auditoria_nueva("Registrar nuevo adelanto", "pagos_adelantos", @pago_adelanto)
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

	    @pago_adelanto = PagoAdelanto.find(params[:id])
	    @pago_adelanto_elim = @pago_adelanto

	    if @valido

	      if @pago_adelanto.destroy

	        auditoria_nueva("Eliminar registro de adelanto", "pagos_adelantos", @pago_adelanto_elim)
	        @eliminado = true

	      end

	    end
	        
	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @registro_gasto = RegistroGasto.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @registro_gasto = RegistroGasto.find(params[:id])
	    auditoria_id = auditoria_antes("actualizar registro gasto", "registros_gastos", @registro_gasto)

	    if valido

	    	@registro_gasto.fecha = params[:registro_gasto][:fecha]
		  	@registro_gasto.gasto_id = params[:registro_gasto][:gasto_id]
		    @registro_gasto.monto = params[:registro_gasto][:monto].to_s.gsub(/[$.]/,'').to_i
		    @registro_gasto.observacion = params[:registro_gasto][:observacion]

	      if @registro_gasto.save

	      	auditoria_despues(@registro_gasto, auditoria_id)
	        @registro_gasto_ok = true

	      end

	    end
	               
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end