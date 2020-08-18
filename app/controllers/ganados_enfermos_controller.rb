class GanadosEnfermosController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_ganado_enfermo_id].present?

      cond << "ganado_enfermo_id = ?"
      args << params[:form_buscar_ganado_enfermo_id]

    end

    if params[:form_buscar_ganado_enfermo_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_ganado_enfermo_fecha]

    end

    if params[:form_buscar_ganado_enfermo_codigo].present?

      cond << "ganado_rfid = ?"
      args << params[:form_buscar_ganado_enfermo_codigo]

    end

    if params[:form_buscar_ganado_enfermo_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_nombre]}%"

    end

    if params[:form_buscar_ganado_enfermo_ganado_rp].present?

      cond << "ganado_rp  ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_ganado_rp]}%"

    end

    if params[:form_buscar_ganado_enfermo][:enfermedad_id].present?

      cond << "enfermedad_id = ?"
      args << params[:form_buscar_ganado_enfermo][:enfermedad_id]

    end

    if params[:form_buscar_ganado_enfermo][:estado_enfermedad_id].present?

      cond << "estado_enfermedad_id = ?"
      args << params[:form_buscar_ganado_enfermo][:estado_enfermedad_id]

    end

    if params[:form_buscar_ganado_enfermo_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_observacion]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_enfermos =  VGanadoEnfermo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEnfermo.where(cond).count

    else
     
      @ganados_enfermos = VGanadoEnfermo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEnfermo.count

    end

    @total_registros = VGanadoEnfermo.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def  ganado_enfermo_detalle

    @ganado_detalle = Ganado.where("id = ?", params[:ganado_id]).first
    @control_sanitario = VControlGanado.orden_fecha.where("ganado_enfermo_id =?", params[:ganado_enfermo_id]).paginate(per_page: 5, page: params[:page])

    respond_to do |f|

      f.js

    end

  end
 
  def eliminar

    @eliminado = false
    @msg = ""

    @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first
    @ganado_enfermo_elim = @ganado_enfermo
    
    if @ganado_enfermo.destroy
      
      @ganado = Ganado.where("id = ?", @ganado_enfermo.ganado_id).first
      auditoria_id = auditoria_antes("Eliminar ganado del modulo de ganados enfermos","ganados",@ganado)
      @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]

      if @ganado.save

        auditoria_despues(auditoria_id, @ganado)
        @eliminado = true

      end

    end
    
    respond_to do |f|

      f.js

    end

  end


end