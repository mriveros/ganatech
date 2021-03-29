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
    @orden_trabajo_detalle = VOrdenTrabajoDetalle.where('orden_trabajo_id = ?', params[:orden_trabajo_id])


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

    Material.transaction do

      @material = Material.where("id = ?", params[:material_id]).first
      auditoria_id = auditoria_antes("guardar suministro material detalle", "materiales", @material)

      if @valido
 
        @material_detalle = MaterialDetalle.new
        @material_detalle.material_id = params[:material_id]
        @material_detalle.descripcion = params[:descripcion].upcase
        @material_detalle.fecha_suministro = params[:fecha_suministro]
        @material_detalle.numero_lote = params[:numero_lote]
        @material_detalle.cantidad_suministro = params[:cantidad_suministro]
        @material_detalle.costo_suministro = params[:costo_suministro].to_s.gsub(/[$.]/,'').to_i
        @material_detalle.observacion = params[:observacion]
        @material_detalle.costo_total = (params[:costo_suministro].to_s.gsub(/[$.]/,'').to_i * params[:cantidad_suministro].to_i)
        
        
        if @material_detalle.save


          auditoria_nueva("agregar material detalle", "materiales_detalles", @material_detalle)

          @material.cantidad_stock = @material.cantidad_stock + @material_detalle.cantidad_suministro
          
          if @material.save

            auditoria_despues(@material, auditoria_id)
            @guardado_ok = true

            @compra = AuxCompra.new
            @compra.fecha = Date.today
            @compra.descripcion = "Compra material: #{@material.nombre_material}"
            @compra.observacion = @material_detalle.observacion
            @compra.monto = @material_detalle.costo_total
            @compra.material_detalle_id = @material_detalle.id
            @compra.save

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

    Material.transaction do

      @material = Material.where("id = ?", params[:material_id]).first
      auditoria_id = auditoria_antes("eliminar suministro material detalle", "materiales", @material)

      @material_detalle = MaterialDetalle.where("id = ?", params[:material_detalle_id]).first
      auditoria_id = auditoria_antes("eliminar suministro material detalle", "materiales_detalles", @material_detalle)

      @compra_material = AuxCompra.where("material_detalle_id = ?", params[:material_detalle_id]).first
      @compra_material.destroy

      if @valido

        @material_detalle_elim = @material_detalle

        if @material_detalle.destroy

          auditoria_nueva("eliminar material detalle", "materiales_detalles", @material_detalle_elim )

          @material.cantidad_stock = @material.cantidad_stock - @material_detalle.cantidad_suministro
          
          if @material.save

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