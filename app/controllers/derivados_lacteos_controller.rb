class DerivadosLacteosController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_derivados_lacteos_id].present?

      cond << "derivado_lacteo_id = ?"
      args << params[:form_buscar_derivados_lacteos_id]

    end

    if params[:form_buscar_derivados_lacteos_tipo_derivado].present?

      cond << "tipo_derivado ilike ?"
      args << "%#{params[:form_buscar_derivados_lacteos_tipo_derivado]}%"

    end

    if params[:form_buscar_derivados_lacteos_cantidad_inicial].present?

      cond << "cantidad_inicial = ?"
      args << params[:form_buscar_derivados_lacteos_cantidad_inicial]

    end

    if params[:form_buscar_derivados_lacteos_cantidad_disponible].present?

      cond << "cantidad_actual = ?"
      args << params[:form_buscar_derivados_lacteos_cantidad_disponible]

    end

    if params[:form_buscar_derivados_lacteos][:tipo_medicion_id].present?

      cond << "tipo_medicion_id = ?"
      args << params[:form_buscar_derivados_lacteos][:tipo_medicion_id]

    end

    if params[:form_buscar_derivados_lacteos][:estado_derivado_lacteo_id].present?

      cond << "estado_derivado_lacteo_id = ?"
      args << params[:form_buscar_derivados_lacteos][:estado_derivado_lacteo_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @derivados_lacteos =  VDerivadoLacteo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VDerivadoLacteo.where(cond).count

    else

      @derivados_lacteos = VDerivadoLacteo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VDerivadoLacteo.count

    end

    @total_registros = VDerivadoLacteo.count

    respond_to do |f|

      f.js

    end

  end

   

  def derivado_lacteo_detalle

    @derivado_lacteo = DerivadoLacteo.where("id = ?", params[:derivado_lacteo_id] ).first
    @derivado_lacteo_detalle = DerivadoLacteoDetalle.where("derivado_lacteo_id = ?", params[:derivado_lacteo_id]).paginate(per_page: 10, page: params[:page])


    respond_to do |f|

      f.js

    end

  end


  def agregar_salida_derivado_lacteo

    @derivado_lacteo_detalle = DerivadoLacteoDetalle.new

    respond_to do |f|

      f.js
      
    end

  end


  def guardar_salida_derivado_lacteo

    @msg = ""
    @valido = true
    @guardado_ok = false


    if @valido

      @derivado_lacteo_detalle = DerivadolacteoDetalle.new
      @derivado_lacteo_detalle.alta_produccion_id = params[:alta_produccion_id]
      @derivado_lacteo_detalle.desde_fecha = params[:desde_fecha]
      @derivado_lacteo_detalle.hasta_fecha = params[:hasta_fecha]
      @derivado_lacteo_detalle.cantidad_litros = params[:cantidad_litros]
      @derivado_lacteo_detalle.estado_derivado_lacteo_detalle_id = PARAMETRO[:estado_derivado_lacteo_detalle_disponible]
      if @derivado_lacteo_detalle.save

        @guardado_ok = true

      end

    end

    respond_to do |f|

      f.js
      
    end

  end


  def eliminar_salida_derivado_lacteo

    @valido = true
    @msg = ""
    @eliminado = false
        
    respond_to do |f|

      f.js

    end

  end
 

end