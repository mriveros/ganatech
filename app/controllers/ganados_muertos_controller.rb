class GanadosMuertosController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_ganado_muerto_id].present?

      cond << "ganado_muerto_id = ?"
      args << params[:form_buscar_ganado_muerto_id]

    end

    if params[:form_buscar_ganado_muerto_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_ganado_muerto_fecha]

    end

    if params[:form_buscar_ganado_muerto_codigo].present?

      cond << "ganado_rfid = ?"
      args << params[:form_buscar_ganado_muerto_codigo]

    end

    if params[:form_buscar_ganado_muerto_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_ganado_muerto_nombre]}%"

    end

    if params[:form_buscar_ganado_muerto_ganado_rp].present?

      cond << "ganado_rp  ilike ?"
      args << "%#{params[:form_buscar_ganado_muerto_ganado_rp]}%"

    end

    if params[:form_buscar_ganado_muerto][:motivo_muerte_id].present?

      cond << "motivo_muerte_id = ?"
      args << params[:form_buscar_ganado_muerto][:motivo_muerte_id]

    end

    if params[:form_buscar_ganado_muerto_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_ganado_muerto_observacion]}%"

    end

    if params[:form_buscar_ganado_muerto_fecha_desde].present?

      cond << "fecha >= ?"
      args << params[:form_buscar_ganado_muerto_fecha_desde]

    end

    if params[:form_buscar_ganado_muerto_fecha_hasta].present?

      cond << "fecha <= ?"
      args << params[:form_buscar_ganado_muerto_fecha_hasta]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_muertos =  VGanadoMuerto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoMuerto.where(cond).count
 
    else
     
      @ganados_muertos = VGanadoMuerto.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoMuerto.count

    end

    @parametros = { format: :pdf, ganado_muerto_id: @ganados_muertos.map(&:ganado_muerto_id), motivo_muerte: params[:form_buscar_ganado_muerto][:motivo_muerte_id], fecha: params[:form_buscar_ganado_muerto_fecha], observacion: params[:form_buscar_ganado_muerto_observacion], fecha_desde: params[:form_buscar_ganado_muerto_fecha_desde], fecha_hasta: params[:form_buscar_ganado_muerto_fecha_hasta]}
    @total_registros = VGanadoMuerto.count

    respond_to do |f|
      
     f.js
      
    end

  end


  def exportar_pdf
    
          
    @ganados_muertos =  VGanadoMuerto.where("ganado_muerto_id in (?)", params[:ganado_muerto_id]).orden_01.paginate(per_page: 10, page: params[:page])
      
    respond_to do |f|
      
      f.pdf do

          render  :pdf => "planilla_resumen_ganado_muerto#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'ganados_muertos/planilla_reporte_ganado_muerto.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "ganados_muertos/cabecera_planilla_resumen_ganado_muerto.pdf.erb" ,
                  :locals   => { :ganado_muerto => @ganados_muertos }}},
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