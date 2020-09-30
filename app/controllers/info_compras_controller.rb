class InfoComprasController < ApplicationController

before_filter :require_usuario

  def index


 
  end
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_info_compras_id].present?

      cond << "id = ?"
      args << params[:form_buscar_info_compras_id]

    end

    if params[:form_buscar_info_compras_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_info_compras_fecha]

    end
  
    if params[:form_buscar_info_compras_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_info_compras_descripcion]}%"

    end

    if params[:form_buscar_info_compras_monto].present?

      cond << "monto = ?"
      args << params[:form_buscar_info_compras_monto]

    end

    if params[:form_buscar_info_compras_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_info_compras_observacion]}%"

    end

    if params[:form_buscar_info_compras_fecha_desde].present?

      cond << "fecha >= ?"
      args << params[:form_buscar_info_compras_fecha_desde]

    end

    if params[:form_buscar_info_compras_fecha_hasta].present?

      cond << "fecha <= ?"
      args << params[:form_buscar_info_compras_fecha_hasta]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @aux_compras =  AuxCompra.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxCompra.where(cond).count

    else
     
      @aux_compras = AuxCompra.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxCompra.count

    end

    @total_registros = AuxCompra.count

    @parametros = { format: :pdf, compra_id: @aux_compras.map(&:id), fecha: params[:form_buscar_info_compras_fecha], descripcion: params[:form_buscar_info_compras_descripcion], monto: params[:form_buscar_info_compras_monto], observacion: params[:form_buscar_info_compras_fecha_desde], fecha_desde: params[:form_buscar_info_compras_fecha_desde], fecha_hasta: params[:form_buscar_info_compras_fecha_hasta]}


    respond_to do |f|
      
     f.js
      
    end

  end

  def exportar_pdf
    
    if params[:compra_id].present?

    @aux_compras =  AuxCompra.where("id in (?)", params[:compra_id]).orden_01.paginate(per_page: 10, page: params[:page])

    respond_to do |f|
      
      f.pdf do

          render  :pdf => "planilla_resumen_compra_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'info_compras/planilla_reporte_compra.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "info_compras/cabecera_planilla_resumen_compra.pdf.erb" ,
                  :locals   => { :compra => @aux_compras }}},
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