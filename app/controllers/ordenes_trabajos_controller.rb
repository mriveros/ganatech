class OrdenTrabajoController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_orden_trabajo_id].present?

      cond << "orden_trabajo_id = ?"
      args << params[:form_buscar_orden_trabajo_id]

    end

    if params[:form_buscar_orden_trabajo_codigo].present?

      cond << "codigo_lote = ?"
      args << params[:form_buscar_orden_trabajo_codigo]

    end

    if params[:form_buscar_orden_trabajo][:material_id].present?

      cond << "material_id = ?"
      args << params[:form_buscar_orden_trabajo][:material_id]

    end

    if params[:form_buscar_orden_trabajo][:orden_trabajo].present?

      cond << "orden_trabajo = ?"
      args << params[:form_buscar_orden_trabajo][:orden_trabajo]

    end

    if params[:form_buscar_orden_trabajo_cantidad_utilizada].present?

      cond << "cantidad_utilizada = ?"
      args << params[:form_buscar_orden_trabajo_cantidad_utilizada]

    end

    if params[:form_buscar_orden_trabajo_fecha_trabajo].present?

      cond << "fecha_trabajo = ?"
      args << params[:form_buscar_orden_trabajo_fecha_trabajo]

    end

    if params[:form_buscar_orden_trabajo][:estado_trabajo_id].present?

      cond << "estado_trabajo_id = ?"
      args << params[:form_buscar_orden_trabajo][:estado_trabajo_id]

    end

    if params[:form_buscar_orden_trabajo_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_orden_trabajo_observacion]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @orden_trabajo =  VOrdenTrabajo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VOrdenTrabajo.where(cond).count

    else
     
      @orden_trabajo = VOrdenTrabajo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VOrdenTrabajo.count

    end

    @total_registros = VOrdenTrabajo.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @orden_trabajo = OrdenTrabajo.new
    nuevo_incremento = OrdenTrabajo.last
    if nuevo_incremento.present?

      @codigo_control = nuevo_incremento.codigo_lote + 1

    else

      @codigo_control = 1

    end
    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = " "
    @guardado_ok = false
    
    if @valido

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        
        @alimentacion = OrdenTrabajo.new
        @alimentacion.ganado_id = params[:ganado_id]
        @alimentacion.fecha_control = params[:fecha_control]
        @alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
        @alimentacion.alimentacion_id = params[:alimentacion_id]
        @alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
        @alimentacion.codigo_lote = params[:codigo_lote]
        @alimentacion.clasificacion_alimentacion_id = params[:clasificacion_alimentacion][:id]
        @alimentacion.observacion = params[:observacion]

        if @alimentacion.save

          @guardado_ok = true

        end

      end

     respond_to do |f|

      f.js

    end
  
  end

 
 def eliminar

    @eliminado = false
    @msg = ""

    @alimentacion = OrdenTrabajo.where("id = ?", params[:orden_trabajo_id]).first
    @alimentacion_elim = @alimentacion
    
    if @alimentacion.destroy
    
      @eliminado = true

    end
    
    respond_to do |f|

      f.js

    end

  end

end