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

	    @total_registros = VRegistroGasto.count
	    @parametros = { format: :pdf, registro_gasto_id: @info_gastos.map(&:registro_gasto_id), fecha: params[:form_buscar_info_gastos_fecha], gasto: params[:form_buscar_info_gastos_gasto], monto: params[:form_buscar_info_gastos_monto], observacion: params[:form_buscar_info_gastos_fecha_desde], fecha_desde: params[:form_buscar_info_gastos_fecha_desde], fecha_hasta: params[:form_buscar_info_gastos_fecha_hasta]}

	    respond_to do |f|

	      f.js

	    end

	end


def exportar_pdf 

    @aux_gastos =  VRegistroGasto.where("registro_gasto_id in (?)", params[:registro_gasto_id]).orden_01.paginate(per_page: 10, page: params[:page])
      
    respond_to do |f|
      
      f.pdf do

          render  :pdf => "planilla_resumen_gasto_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'info_gastos/planilla_reporte_gasto.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "info_gastos/cabecera_planilla_resumen_gasto.pdf.erb" ,
                  :locals   => { :gasto => @aux_gastos }}},
                  :margin => {:top => 65,
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Landscape',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }

      end
      
    end
end

end