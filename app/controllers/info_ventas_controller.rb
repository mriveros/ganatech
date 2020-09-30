class InfoVentasController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_info_ventas_id].present?

      cond << "id = ?"
      args << params[:form_buscar_info_ventas_id]

    end

    if params[:form_buscar_info_ventas_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_info_ventas_fecha]

    end

    if params[:form_buscar_info_ventas_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_info_ventas_descripcion]}%"

    end

    if params[:form_buscar_info_ventas_monto].present?

      cond << "monto = ?"
      args << params[:form_buscar_info_ventas_monto]

    end

    if params[:form_buscar_info_ventas_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_info_ventas_observacion]}%"

    end

    if params[:form_buscar_info_ventas_fecha_desde].present?

      cond << "fecha >= ?"
      args << params[:form_buscar_info_ventas_fecha_desde]

    end

    if params[:form_buscar_info_ventas_fecha_hasta].present?

      cond << "fecha <= ?"
      args << params[:form_buscar_info_ventas_fecha_hasta]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @aux_ventas =  AuxVenta.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxVenta.where(cond).count

    else
     
      @aux_ventas = AuxVenta.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxVenta.count

    end

    @total_registros = AuxVenta.count
    
    @parametros = { format: :pdf, venta_id: @aux_ventas.map(&:id), fecha: params[:form_buscar_info_ventas_fecha], descripcion: params[:form_buscar_info_ventas_descripcion], monto: params[:form_buscar_info_ventas_monto], observacion: params[:form_buscar_info_ventas_fecha_desde], fecha_desde: params[:form_buscar_info_ventas_fecha_desde], fecha_hasta: params[:form_buscar_info_ventas_fecha_hasta]}

    respond_to do |f|
      
     f.js
      
    end

    def exportar_pdf
    
          
    @aux_ventas =  AuxVenta.where("id in (?)", params[:venta_id]).orden_01.paginate(per_page: 10, page: params[:page])
      
    respond_to do |f|
      
      f.pdf do

          render  :pdf => "planilla_resumen_venta_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'info_ventas/planilla_reporte_venta.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "info_ventas/cabecera_planilla_resumen_venta.pdf.erb" ,
                  :locals   => { :venta => @aux_ventas }}},
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

end