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

      cond << "estado_orden_trabajo_id = ?"
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


  def editar

    @orden_trabajo = OrdenTrabajo.find(params[:id])

    respond_to do |f|

      f.js

    end

  end


  def actualizar

    valido = true
    @msg = ""

    @orden_trabajo = OrdenTrabajo.find(params[:orden_trabajo_id])

    auditoria_id = auditoria_antes("actualizar orden de trabajo", "ordenes_trabajos", @orden_trabajo)

    if valido

      @orden_trabajo.trabajo_id = params[:orden_trabajo][:trabajo_id]
      @orden_trabajo.descripcion = params[:orden_trabajo][:descripcion]
      @orden_trabajo.fecha_trabajo = params[:orden_trabajo][:fecha_trabajo]
      @orden_trabajo.estado_orden_trabajo_id = params[:orden_trabajo][:estado_orden_trabajo_id]
      @orden_trabajo.observacion = params[:orden_trabajo][:observacion]

      if  @orden_trabajo.save

        auditoria_despues(@orden_trabajo, auditoria_id)
        @orden_trabajo_ok = true

      end

    end

  rescue Exception => exc
    # dispone el mensaje de error
    #puts "Aqui si muestra el error ".concat(exc.message)
    if exc.present?

      @msg = exc.message.split(':')

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

  def trabajos_detalles

    @orden_trabajo = OrdenTrabajo.where('id = ?', params[:orden_trabajo_id]).first
    @orden_trabajo_detalle = VOrdenTrabajoDetalle.where('orden_trabajo_id = ?', params[:orden_trabajo_id]).paginate(per_page: 10, page: params[:page])


    respond_to do |f|

      f.js

    end

  end

  def agregar_material_trabajo


    @orden_trabajo = OrdenTrabajo.where("id = ?", params[:orden_trabajo_id]).first

    respond_to do |f|

      f.js

    end

  end

  def guardar_material_trabajo

    @guardado_ok = false
    @valido = true

    OrdenTrabajoDetalle.transaction do

      @orden_trabajo = OrdenTrabajo.where("id = ?", params[:orden_trabajo_id]).first
      @material = Material.where("id = ?",params[:material][:id]).first
      auditoria_id = auditoria_antes("actualizar orden de trabajo", "ordenes_trabajos", @material)

      if @material.cantidad_stock < params[:cantidad_utilizada].to_i

        @valido = false
        @msg = "No hay suficiente stock de material."

      end

      if @valido
 
        @orden_trabajo_detalle = OrdenTrabajoDetalle.new
        @orden_trabajo_detalle.material_id = params[:material][:id]
        @orden_trabajo_detalle.orden_trabajo_id =  params[:orden_trabajo_id]
        @orden_trabajo_detalle.cantidad_utilizada = params[:cantidad_utilizada]
        @orden_trabajo_detalle.fecha = params[:fecha]
        @orden_trabajo_detalle.observacion = params[:observacion] 
        
        if @orden_trabajo_detalle.save

          @material.cantidad_stock = @material.cantidad_stock - @orden_trabajo_detalle.cantidad_utilizada
          
          if @material.save

            auditoria_despues(@material, auditoria_id)
            @guardado_ok = true

          end

        end

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_material_trabajo

    @eliminado_ok = false
    @valido = true

    OrdenTrabajoDetalle.transaction do

      @orden_trabajo_detalle = OrdenTrabajoDetalle.where("id = ?", params[:orden_trabajo_detalle_id]).first
      
      @material = Material.where("id = ?", @orden_trabajo_detalle.material_id).first
      auditoria_id = auditoria_antes("eliminar suministro orden trabajo detalle", "materiales", @material)


      if @valido

        @orden_trabajo_detalle_elim = @orden_trabajo_detalle

        if @orden_trabajo_detalle.destroy

          auditoria_nueva("eliminar orden trabajo detalle", "ordenes_trabajos_detalles", @orden_trabajo_detalle_elim )

          @material.cantidad_stock = @material.cantidad_stock + @orden_trabajo_detalle_elim.cantidad_utilizada
          
          if @material.save

            auditoria_despues(@material, auditoria_id)
            @eliminado_ok = true

          end

        end

      end

    end

    respond_to do |f|

      f.js

    end

  end



end