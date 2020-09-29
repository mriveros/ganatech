class InfoGastosController < ApplicationController

	before_filter :require_usuario

	  def index
	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_info_gastos_id].present?

	      cond << "id = ?"
	      args << params[:form_buscar_info_gastos_id]

	    end

	    if params[:form_buscar_info_gastos_gasto].present?

	      cond << "gasto ilike ?"
	      args << "%#{params[:form_buscar_info_gastos_gasto]}%"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @info_gastos =  VRegistroGasto.orden_fecha_desc.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = RegistroGasto.where(cond).count

	    else

	      @info_gastos = VRegistroGasto.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = RegistroGasto.count

	    end

	    @total_registros = RegistroGasto.count

	    respond_to do |f|

	      f.js

	    end

	end

end