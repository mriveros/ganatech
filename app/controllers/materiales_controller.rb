class MaterialesController < ApplicationController

  before_filter :require_usuario

  def index


  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_materiales_id].present?

      cond << "material_id = ?"
      args << params[:form_buscar_materiales_id]

    end

    if params[:form_buscar_materiales_nombre_material].present?

      cond << "nombre_material ilike ?"
      args << "%#{params[:form_buscar_materiales_nombre_material]}%"

    end


    if params[:form_buscar_materiales_cantidad_stock].present?

      cond << "cantidad_stock = ?"
      args << params[:form_buscar_materiales_cantidad_stock]

    end

    if params[:form_buscar_materiales_costo_unitario].present?

      cond << "costo_unitario = ?"
      args << params[:form_buscar_materiales_costo_unitario]

    end

    if params[:form_buscar_materiales][:estado_material_id].present?

      cond << "estado_material_id = ?"
      args << params[:form_buscar_materiales][:estado_material_id]

    end


    if params[:form_buscar_materiales][:presentacion_material_id].present?

      cond << "presentacion_material_id = ?"
      args << params[:form_buscar_materiales][:presentacion_material_id]

    end



    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @materiales =  VMaterial.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VMaterial.where(cond).count

    else

      @materiales = VMaterial.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VMaterial.count

    end

    @total_registros = VMaterial.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @material = Material.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""
    @material_ok = false

    MaterialDetalle.transaction do

      @material = Material.new() 

      @material.nombre_material = params[:nombre_material].upcase
      @material.cantidad_stock = params[:cantidad_stock]
      @material.costo_unitario = params[:costo_unitario].to_s.gsub(/[$.]/,'').to_i
      @material.observacion = params[:observacion]
      @material.estado_material_id = params[:estado_material][:id]
      @material.presentacion_material_id = params[:presentacion_material][:id]
      
      

      if @material.save

        auditoria_nueva("agregar nueva material", "materiales", @material)
        @material_detalle = MaterialDetalle.new
        @material_detalle.material_id = @material.id
        @material_detalle.descripcion = @material.nombre_material
        @material_detalle.fecha_suministro = Date.today
        @material_detalle.numero_lote = 0
        @material_detalle.cantidad_suministro = @material.cantidad_stock
        @material_detalle.costo_suministro = @material.costo_unitario
        @material_detalle.observacion = @material.observacion
        @material_detalle.costo_total =  (params[:costo_unitario].to_s.gsub(/[$.]/,'').to_i * params[:cantidad_stock].to_i)

        if @material_detalle.save

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

  rescue Exception => exc
    
    if exc.present?
      
      @excep = exc.message.split(':')
      @msg = @excep

    end


    respond_to do |f|

      f.js

    end

  end

  def eliminar

    @eliminado = false
    @valido = true
    @msg = ""

    @material = Material.where("id = ?",params[:id]).first
    @material_elim = @material

    material_ganado = UsoMaterial.where("material_id = ?",params[:id])
    if material_ganado.present?

      @msg += "El material ya ha sido utilizado."
      @valido = false

    end

    material_detalle = MaterialDetalle.where("material_id = ?",params[:id])
    if material_detalle.present?

      @msg += " El material ya cuenta con suministros."
      @valido = false

    end

    if @valido

      if @material.destroy

        auditoria_nueva("eliminar material", "materiales", @material_elim)
        @eliminado = true

      end

    end

  rescue Exception => exc
    # dispone el mensaje de error
    #puts "Aqui si muestra el error ".concat(exc.message)
    if exc.present?

      @eliminado = false

    end

    respond_to do |f|

      f.js

    end

  end


  def editar

    @material = Material.find(params[:id])

    respond_to do |f|

      f.js

    end

  end


  def actualizar

    valido = true
    @msg = ""

    @material = Material.find(params[:material][:id])
    auditoria_id = auditoria_antes("actualizar material", "materials", @material)

    if valido

      @material.nombre_material = params[:material][:nombre_material].upcase
      @material.cantidad_stock = params[:material][:cantidad_stock]
      @material.costo_unitario = params[:material][:costo_unitario].to_s.gsub(/[$.]/,'').to_i
      @material.observacion = params[:material][:observacion]
      @material.estado_material_id = params[:material][:estado_material_id]
      @material.presentacion_material_id = params[:material][:presentacion_material_id]
     
      if @material.save

        auditoria_despues(@material, auditoria_id)
        @material_ok = true

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


  def buscar_material

    #if params[:tipo_material].present?

    @materiales = Material.where("nombre_material ilike ? and presentacion_material_id = ?", "%#{params[:material]}%", params[:presentacion_material_id])

    #end

    respond_to do |f|

      f.html
      f.json { render :json => @materiales }

    end

  end

  def material_detalle

    @material = Material.where("id = ?", params[:material_id]).first

    @material_detalle = MaterialDetalle.orden_01.where("material_id = ?", params[:material_id]).paginate(per_page: 5, page: params[:page])


    respond_to do |f|

      f.js

    end

  end

  def agregar_material_detalle


    @material = Material.where("id = ?", params[:material_id]).first
    nuevo_codigo = MaterialDetalle.last
    @numero_lote = nuevo_codigo.numero_lote + 1

    respond_to do |f|

      f.js

    end

  end

  def guardar_material_detalle

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

  def eliminar_material_detalle

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