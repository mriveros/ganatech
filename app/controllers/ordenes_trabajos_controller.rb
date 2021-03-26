class OrdenesTrabajosController < ApplicationController

  before_filter :require_usuario

  def index

  end  
 
  def lista

    cond = []
    args = [] 

    if params[:form_buscar_ordenes_trabajos_id].present?

      cond << "orden_trabajo_id = ?"
      args << params[:form_buscar_ordenes_trabajos_id]

    end

    if params[:form_buscar_ordenes_trabajos_descripcion].present?

      cond << "descripcion = ?"
      args << params[:form_buscar_ordenes_trabajos_descripcion]

    end

    if params[:form_buscar_ordenes_trabajos][:trabajo_id].present?

      cond << "trabajo_id = ?"
      args << params[:form_buscar_ordenes_trabajos][:trabajo_id]

    end

    if params[:form_buscar_ordenes_trabajos][:fecha_trabajo].present?

      cond << "fecha_trabajo = ?"
      args << params[:form_buscar_ordenes_trabajos][:fecha_trabajo]

    end

    
    if params[:form_buscar_ordenes_trabajos][:estado_trabajo_id].present?

      cond << "estado_trabajo_id = ?"
      args << params[:form_buscar_ordenes_trabajos][:estado_trabajo_id]

    end

    if params[:form_buscar_ordenes_trabajos_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_ordenes_trabajos_observacion]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ordenes_trabajos =  VOrdenTrabajo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VOrdenTrabajo.where(cond).count

    else
     
      @ordenes_trabajos = VOrdenTrabajo.orden_01.paginate(per_page: 10, page: params[:page])
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

      @orden_trabajo = OrdenTrabajo.new
      @orden_trabajo.trabajo_id = params[:trabajo][:id]
      @orden_trabajo.descripcion = params[:descripcion]
      @orden_trabajo.fecha_trabajo = params[:fecha_trabajo]
      @orden_trabajo.estado_orden_trabajo_id = params[:estado_orden_trabajo][:id]
      @orden_trabajo.observacion = params[:observacion]
      if  @orden_trabajo.save

        @guardado_ok =  true

      end

    end

    respond_to do |f|

      f.js

    end
  
  end

 
  def eliminar

    @eliminado = false
    @msg = ""

    @orden_trabajo = OrdenTrabajo.where("id = ?", params[:orden_trabajo_id]).first
    @orden_trabajo_elim = @orden_trabajo
    
    if @orden_trabajo.destroy
    
      @eliminado = true

    end
    
    respond_to do |f|

      f.js

    end

  end

end