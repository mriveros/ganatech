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

	    if params[:form_buscar_pagos_adelantos_personal_nombre].present?

	      cond << "personal_nombre ilike ?"
	      args << "%#{params[:form_buscar_pagos_adelantos_personal_nombre]}%"

	    end

	    if params[:form_buscar_pagos_adelantos_personal_apellido].present?

	      cond << "personal_apellido ilike ?"
	      args << "%#{params[:form_buscar_pagos_adelantos_personal_apellido]}%"

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

	      @registros_gastos = VPagoAdelanto.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
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

	    if @valido

		    @registro_gasto = RegistroGasto.new()
		    @registro_gasto.fecha = params[:fecha]
		    @registro_gasto.gasto_id = params[:gasto][:id]
		    @registro_gasto.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
		    @registro_gasto.observacion = params[:observacion]

		    if @registro_gasto.save

		    	auditoria_nueva("Registrar nuevo gasto", "registros_gastos", @registro_gasto)
		       
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

	    @registro_gasto = RegistroGasto.find(params[:id])
	    @registro_gasto_elim = @registro_gasto

	    if @valido

	      if @registro_gasto.destroy

	        auditoria_nueva("Eliminar registro de gastos", "registros_gastos", @registro_gasto_elim)
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