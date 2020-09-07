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
    @valido = false
    @guardado_ok = false

    @derivado_lacteo = DerivadoLacteo.where("id = ?", params[:derivado_lacteo_id]).first
    if @derivado_lacteo.cantidad_actual < params[:cantidad_salida]

      @valido = false
      @msg = "La Cantidad de Salida no puede ser mayor a la cantidad disponible en Stock" 

    end

    if @valido

      @derivado_lacteo_detalle = DerivadolacteoDetalle.new
      @derivado_lacteo_detalle.derivado_lacteo_id = params[:derivado_lacteo_id]
      @derivado_lacteo_detalle.fecha_salida = params[:fecha_salida]
      @derivado_lacteo_detalle.tipo_salida_derivado_id = params[:tipo_salida_derivado][:id]
      @derivado_lacteo_detalle.cantidad_salida = params[:cantidad_salida]
      @derivado_lacteo_detalle.monto = params[:monto]
      @derivado_lacteo_detalle.cliente_id = params[:cliente_id]
      @derivado_lacteo_detalle.cantidad_litros = params[:cantidad_litros]

      if params[:tipo_salida_derivado][:id] == PARAMETRO[:tipo_salida_derivado_lacteo_consumo_local]
   
        @derivado_lacteo_detalle.estado_derivado_lacteo_detalle_id = PARAMETRO[:tipo_salida_derivado_lacteo_consumo_local]

      else

        @derivado_lacteo_detalle.estado_derivado_lacteo_detalle_id = PARAMETRO[:tipo_salida_derivado_lacteo_venta]

      end 
      
      @derivado_lacteo_detalle.observacion = params[:observacion]

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