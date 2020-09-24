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
		       	@pago_salario = PagoSalario.where("mes_periodo_id = ? and anho_periodo = ?", params[:mes_periodo][:id],params[:anho_periodo]).first
		        
		        if @pago_salario.present?

		        	@total_adelantos = PagoAdelanto.where("mes_periodo_id = ? and anho_periodo = ?", params[:mes_periodo][:id], params[:anho_periodo]).sum(:monto)
				    @total_descuentos = PagoDescuento.where("mes_periodo_id = ? and anho_periodo = ?", params[:mes_periodo][:id], params[:anho_periodo]).sum(:monto)
				    @total_remuneraciones_extras = PagoRemuneracionExtra.where("mes_periodo_id = ? and anho_periodo = ?", params[:mes_periodo][:id], params[:anho_periodo]).sum(:monto)
					
					@pago_salario_detalle = PagoSalarioDetalle.where("pago_salario_id = ?", @pago_salario.id)
					@pago_salario_detalle.each do |psd|

						@personal_salario = VPersonal.where("personal_id = ?", psd.personal_id).first
			            @personal_total_adelantos = PagoAdelanto.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?",psd.personal_id, params[:mes_periodo][:id],params[:anho_periodo]).sum(:monto).to_i
			            @personal_total_descuentos = PagoDescuento.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?", psd.personal_id, params[:mes_periodo][:id],params[:anho_periodo]).sum(:monto).to_i
			            @personal_total_remuneracion_extra = PagoRemuneracionExtra.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?", psd.personal_id, params[:mes_periodo][:id],params[:anho_periodo]).sum(:monto).to_i
			            @personal_sueldo_percibido = (@personal_salario.sueldo.to_i + @personal_total_remuneracion_extra) - (@personal_total_adelantos + @personal_total_descuentos)
			            @acumulacion_sueldo_percibido = @acumulacion_sueldo_percibido.to_i + @personal_sueldo_percibido.to_i

			            psd.adelantos = @personal_total_adelantos
              			psd.descuentos = @personal_total_descuentos
              			psd.otras_remuneraciones = @personal_total_remuneracion_extra
              			psd.salario_percibido = @personal_sueldo_percibido

              			if psd.save

              			end

					end

					@pago_salario.monto_total_pagado = @acumulacion_sueldo_percibido
					
					if @pago_salario.save

			           @guardado_ok = true

			        end

		        end

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
	        @pago_salario = PagoSalario.where("mes_periodo_id = ? and anho_periodo = ?", @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).first
		        
		    if @pago_salario.present?

		        @total_adelantos = PagoAdelanto.where("mes_periodo_id = ? and anho_periodo = ?", @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).sum(:monto)
				@total_descuentos = PagoDescuento.where("mes_periodo_id = ? and anho_periodo = ?", @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).sum(:monto)
				@total_remuneraciones_extras = PagoRemuneracionExtra.where("mes_periodo_id = ? and anho_periodo = ?", @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).sum(:monto)
					
				@pago_salario_detalle = PagoSalarioDetalle.where("pago_salario_id = ?", @pago_salario.id)
				@pago_salario_detalle.each do |psd|

					@personal_salario = VPersonal.where("personal_id = ?", psd.personal_id).first
			        @personal_total_adelantos = PagoAdelanto.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?",psd.personal_id, @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).sum(:monto).to_i
			        @personal_total_descuentos = PagoDescuento.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?", psd.personal_id, @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).sum(:monto).to_i
			        @personal_total_remuneracion_extra = PagoRemuneracionExtra.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?", psd.personal_id, @pago_descuento_elim.mes_periodo_id, @pago_descuento_elim.anho_periodo).sum(:monto).to_i
			        @personal_sueldo_percibido = (@personal_salario.sueldo.to_i + @personal_total_remuneracion_extra) - (@personal_total_adelantos + @personal_total_descuentos)
			        @acumulacion_sueldo_percibido = @acumulacion_sueldo_percibido.to_i + @personal_sueldo_percibido.to_i

			        psd.adelantos = @personal_total_adelantos
              		psd.descuentos = @personal_total_descuentos
              		psd.otras_remuneraciones = @personal_total_remuneracion_extra
              		psd.salario_percibido = @personal_sueldo_percibido

              		if psd.save

              		end

				end

				@pago_salario.monto_total_pagado = @acumulacion_sueldo_percibido
					
				if @pago_salario.save

			        @guardado_ok = true

			    end

		    end

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
		       	@pago_salario = PagoSalario.where("mes_periodo_id = ? and anho_periodo = ?", params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).first
		        
		        if @pago_salario.present?

		        	@total_adelantos = PagoAdelanto.where("mes_periodo_id = ? and anho_periodo = ?", params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).sum(:monto)
				    @total_descuentos = PagoDescuento.where("mes_periodo_id = ? and anho_periodo = ?", params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).sum(:monto)
				    @total_remuneraciones_extras = PagoRemuneracionExtra.where("mes_periodo_id = ? and anho_periodo = ?",params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).sum(:monto)
					
					@pago_salario_detalle = PagoSalarioDetalle.where("pago_salario_id = ?", @pago_salario.id)
					@pago_salario_detalle.each do |psd|

						@personal_salario = VPersonal.where("personal_id = ?", psd.personal_id).first
			            @personal_total_adelantos = PagoAdelanto.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?",psd.personal_id, params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).sum(:monto).to_i
			            @personal_total_descuentos = PagoDescuento.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?", psd.personal_id, params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).sum(:monto).to_i
			            @personal_total_remuneracion_extra = PagoRemuneracionExtra.where("personal_id = ? and mes_periodo_id = ? and anho_periodo = ?", psd.personal_id, params[:pago_descuento][:mes_periodo_id], params[:pago_descuento][:anho_periodo]).sum(:monto).to_i
			            @personal_sueldo_percibido = (@personal_salario.sueldo.to_i + @personal_total_remuneracion_extra) - (@personal_total_adelantos + @personal_total_descuentos)
			            @acumulacion_sueldo_percibido = @acumulacion_sueldo_percibido.to_i + @personal_sueldo_percibido.to_i

			            psd.adelantos = @personal_total_adelantos
              			psd.descuentos = @personal_total_descuentos
              			psd.otras_remuneraciones = @personal_total_remuneracion_extra
              			psd.salario_percibido = @personal_sueldo_percibido

              			if psd.save

              			end

					end

					@pago_salario.monto_total_pagado = @acumulacion_sueldo_percibido
					
					if @pago_salario.save

			           @guardado_ok = true

			        end

		        end
		        
		    end 

		 end
	         
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end