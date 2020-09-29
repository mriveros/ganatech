class InfoGastosController < ApplicationController

	before_filter :require_usuario

	  def index
	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_info_gastos_id].present?

	      cond << "registro_gasto_id = ?"
	      args << params[:form_buscar_info_gastos_id]

	    end

	     if params[:form_buscar_info_gastos_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_info_gastos_fecha]

	    end

	    if params[:form_buscar_info_gastos_monto].present?

	      cond << "monto = ?"
	      args << params[:form_buscar_info_gastos_monto]

	    end

	    if params[:form_buscar_info_gastos_gasto].present?

	      cond << "gasto ilike ?"
	      args << "%#{params[:form_buscar_info_gastos_gasto]}%"

	    end

	    if params[:form_buscar_info_gastos_observacion].present?

	      cond << "observacion ilike ?"
	      args << "%#{params[:form_buscar_info_gastos_observacion]}%"

	    end

	    if params[:form_buscar_info_gastos_fecha_desde].present?

	      cond << "fecha >= ?"
	      args << params[:form_buscar_info_gastos_fecha_desde]

	    end

	    if params[:form_buscar_info_gastos_fecha_hasta].present?

	      cond << "fecha <= ?"
	      args << params[:form_buscar_info_gastos_fecha_hasta]

	    end

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @info_gastos =  VRegistroGasto.orden_fecha_desc.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VRegistroGasto.where(cond).count

	    else

	      @info_gastos = VRegistroGasto.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VRegistroGasto.count

	    end

	    @total_registros = RegistroGasto.count

	    respond_to do |f|

	      f.js

	    end

	end

end