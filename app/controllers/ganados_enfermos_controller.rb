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

      cond << "codigo = ?"
      args << params[:form_buscar_ganado_enfermo_codigo]

    end

    if params[:form_buscar_ganado_enfermo_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_nombre]}%"

    end

    if params[:form_buscar_ganado_enfermo_ganado_rp].present?

      cond << "ganado_rp  = ?"
      args << params[:form_buscar_ganado_enfermo_ganado_rp]

    end

    if params[:form_buscar_ganado_enfermo][:enfermedad_id].present?

      cond << "enfermedad_id = ?"
      args << params[:form_buscar_ganado_enfermo][:enfermedad_id]

    end

    if params[:form_buscar_ganado_enfermo][:estado_enfermedad_id].present?

      cond << "estado_enfermedad_id = ?"
      args << params[:form_buscar_ganado_enfermo][:estado_enfermedad_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @controles_ganados =  VGanadoEnfermo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEnfermo.where(cond).count

    else
     
      @controles_ganados = VGanadoEnfermo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEnfermo.count

    end

    @total_registros = VGanadoEnfermo.count

    respond_to do |f|
      
     f.js
      
    end

  end

 
  def eliminar

    @eliminado = false
    @msg = ""

    @control_ganado = ControlGanado.where("id = ?", params[:control_ganado_id]).first
    @control_ganado_elim = @control_ganado
    
    if @control_ganado.destroy
    
      @eliminado = true

    end
    
    respond_to do |f|

      f.js

    end

  end


end