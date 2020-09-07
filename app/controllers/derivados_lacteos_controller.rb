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

    DerivadoLacteo.transaction do

      @derivado_lacteo = DerivadoLacteo.where("id = ?", params[:derivado_lacteo_id]).first

      auditoria_id = auditoria_antes("Guardar salida derivado lacteo", "derivados_lacteos", @derivado_lacteo)

      if @derivado_lacteo.cantidad_actual < params[:cantidad_salida].to_i

        @valido = false
        @msg = "La Cantidad de Salida no puede ser mayor a la cantidad disponible en Stock" 

      end

      if @valido

        @derivado_lacteo_detalle = DerivadoLacteoDetalle.new
        @derivado_lacteo_detalle.derivado_lacteo_id = params[:derivado_lacteo_id]
        @derivado_lacteo_detalle.fecha_salida = params[:fecha_salida]
        @derivado_lacteo_detalle.tipo_salida_derivado_id = params[:tipo_salida_derivado][:id]
        @derivado_lacteo_detalle.cantidad_salida = params[:cantidad_salida]
        @derivado_lacteo_detalle.monto = params[:monto]
        @derivado_lacteo_detalle.cliente_id = params[:cliente][:id]

        if params[:tipo_salida_derivado][:id] == PARAMETRO[:tipo_salida_derivado_lacteo_consumo_local]
     
          @derivado_lacteo_detalle.estado_derivado_lacteo_detalle_id = PARAMETRO[:tipo_salida_derivado_lacteo_consumo_local]

        else

          @derivado_lacteo_detalle.estado_derivado_lacteo_detalle_id = PARAMETRO[:tipo_salida_derivado_lacteo_venta]

        end 
        
        @derivado_lacteo_detalle.observacion = params[:observacion]

        if @derivado_lacteo_detalle.save

          auditoria_nueva("Agregar nueva salida de derivados lacteos", "derivados_lacteos_detalles", @derivado_lacteo_detalle)
          @guardado_ok = true

          if @derivado_lacteo.cantidad_actual == 0

            @derivado_lacteo.estado_derivado_lacteo_id = PARAMETRO[:estado_derivado_lacteo_sin_stock]
            
            if @derivado_lacteo.save
              
              auditoria_despues(@derivado_lacteo, auditoria_id)

            end

          end
         

        end

      end

    end #end transaction

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