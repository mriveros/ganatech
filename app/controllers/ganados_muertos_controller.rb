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


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_muertos =  VGanadoMuerto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoMuerto.where(cond).count

    else
     
      @ganados_muertos = VGanadoMuerto.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoMuerto.count

    end

    @total_registros = VGanadoMuerto.count

    respond_to do |f|
      
     f.js
      
    end

  end

end