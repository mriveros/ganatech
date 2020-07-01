class AlimentacionesController < ApplicationController

  before_filter :require_usuario

  def index

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_alimentaciones_id].present?

      cond << "alimentacion_id = ?"
      args << params[:form_buscar_alimentaciones_id]

    end


    if params[:form_buscar_alimentaciones_nombre_alimento].present?

      cond << "nombre_alimento ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_nombre_alimento]}%"

    end


    if params[:form_buscar_alimentaciones_descripcion_alimento].present?

      cond << "descripcion_alimento ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_descripcion_alimento]}%"

    end


    if params[:form_buscar_alimentaciones_cantidad_stock].present?

      cond << "cantidad_stock ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_cantidad_stock]}%"

    end


    if params[:form_buscar_alimentaciones_cantidad_aplicacion].present?

      cond << "cantidad_aplicacion ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_cantidad_aplicacion]}%"

    end


    if params[:form_buscar_alimentaciones_ciclo].present?

      cond << "ciclo ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_ciclo]}%"

    end


    if params[:form_buscar_alimentaciones_intervalo_tiempo].present?

      cond << "intervalo_tiempo ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_intervalo_tiempo]}%"

    end


    if params[:form_buscar_alimentaciones_estado_alimento_id].present?

      cond << "estado_alimento_id = ?"
      args << "#{params[:form_buscar_alimentaciones_estado_alimento]}"

    end


    if params[:form_buscar_alimentaciones_tipo_alimentacion_id].present?

      cond << "tipo_alimento_id = ?"
      args << "#{params[:form_buscar_alimentaciones_tipo_alimento]}"

    end


    if params[:form_buscar_alimentaciones_fecha_vencimiento].present?

      cond << "fecha_vencimiento = ?"
      args << "#{params[:form_buscar_alimentaciones_fecha_vencimiento]}"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @alimentaciones =  VAlimentacion.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VAlimentacion.where(cond).count

    else

      @alimentaciones = VAlimentacion.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VAlimentacion.count

    end

    @total_registros = VAlimentacion.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @alimento = Alimentacion.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""
    @alimento_ok = false

    AlimentacionDetalle.transaction do

      @alimento = Alimentacion.new()

      @alimento.descripcion = params[:descripcion].upcase
      @alimento.nombre_alimento = params[:nombre_alimento].upcase
      @alimento.cantidad_stock = params[:cantidad_stock]
      @alimento.cantidad_aplicacion = params[:cantidad_aplicacion]
      @alimento.ciclo = params[:ciclo]
      @alimento.intervalo_tiempo = params[:intervalo_tiempo]
      @alimento.observacion = params[:observacion]
      @alimento.estado_alimento_id = params[:estado_alimento][:id]
      @alimento.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
      @alimento.fecha_vencimiento = params[:fecha_vencimiento]

      if @alimento.save

        auditoria_nueva("agregar nueva alimentacion", "alimentaciones", @alimento)
        @alimentacion_detalle = AlimentacionDetalle.new
        @alimentacion_detalle.medicamento_id = @alimento.id
        @alimentacion_detalle.descripcion = @alimento.descripcion
        @alimentacion_detalle.fecha_suministro = Date.today
        @alimentacion_detalle.numero_lote = 0
        @alimentacion_detalle.cantidad_suministro = @alimento.cantidad_stock
        @alimentacion_detalle.costo_suministro = @alimento.costo
        @alimentacion_detalle.observacion = @alimento.observacion
        @alimentacion_detalle.fecha_vencimiento = @alimento.fecha_vencimiento

        if @alimentacion_detalle.save

          @guardado_ok = true

        end

      end

    end

  rescue Exception => exc
    # dispone el mensaje de error
    #puts "Aqui si muestra el error ".concat(exc.message)
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
    valido = true
    @msg = ""

    @alimento = Alimentacion.find(params[:id])

    @alimentacion_detalle = AlimentacionDetalle.where("alimentacion_id = ?", params[:id])

    @alimento_elim = @alimento

    if controles_ganado.present?

      @msg = "El alimento ya ha sido utilizado en controles de ganados."
      @valido = false

    end

    if @alimentacion_detalle.present?

      @msg += "El alimento ya cuenta con suministros."
      @valido = false

    end

    if valido

      if @alimento.destroy

        auditoria_nueva("eliminar alimento", "alimentaciones", @alimento_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el alimento. Intente más tarde."

      end

    end



  rescue Exception => exc
    # dispone el mensaje de error
    #puts "Aqui si muestra el error ".concat(exc.message)
    if exc.present?

      @msg = exc.message.split(':')
      @eliminado = false
    end

    respond_to do |f|

      f.js

    end

  end

  def editar

    @alimento = Alimentacion.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @alimento = Alimentacion.find(params[:alimentacion_id])
    auditoria_id = auditoria_antes("actualizar alimento", "alimentos", @alimento)

    if valido

      @alimento.descripcion = params[:alimentacion][:descripcion].upcase
      @alimento.nombre_alimento = params[:alimentacion][:nombre_alimento].upcase
      @alimento.cantidad_stock = params[:alimentacion][:cantidad_stock]
      @alimento.cantidad_aplicacion = params[:alimentacion][:cantidad_aplicacion]
      @alimento.ciclo = params[:alimentacion][:ciclo]
      @alimento.intervalo_tiempo = params[:alimentacion][:intervalo_tiempo]
      @alimento.observacion = params[:alimentacion][:observacion]
      @alimento.estado_alimento_id = params[:alimentacion][:estado_alimento_id]
      @alimento.tipo_alimentacion_id = params[:alimentacion][:tipo_alimentacion_id]
      @alimento.fecha_vencimiento = params[:alimentacion][:fecha_vencimiento]

      if @alimento.save

        auditoria_despues(@alimento, auditoria_id)
        @alimentacion_ok = true

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


  def buscar_alimentacion

    #if params[:tipo_alimentacion].present?

    @alimentaciones = Alimentacion.where("nombre_alimento ilike ? and tipo_alimentacion_id = ?", "%#{params[:alimentacion]}%", params[:tipo_alimentacion])

    #end

    respond_to do |f|

      f.html
      f.json { render :json => @alimentaciones }

    end

  end

  def alimentacion_detalle

    @alimentacion = Alimentacion.where("id = ?", params[:alimentacion_id]).first

    @alimentacion_detalle = AlimentacionDetalle.orden_01.where("alimentacion_id = ?", params[:alimentacion_id]).paginate(per_page: 5, page: params[:page])


    respond_to do |f|

      f.js

    end

  end

  def agregar_alimentacion_detalle


    @alimentacion = Alimentacion.where("id = ?", params[:alimentacion_id]).first

    respond_to do |f|

      f.js

    end

  end

  def guardar_alimentacion_detalle

    @guardado_ok = false
    @valido = true

    Alimentacion.transaction do

      @alimentacion = Alimentacion.where("id = ?", params[:alimentacion_id]).first
      auditoria_id = auditoria_antes("guardar suministro alimentacion detalle", "alimentaciones", @alimentacion)

      if @valido

        @alimentacion_detalle = AlimentacionDetalle.new
        @alimentacion_detalle.alimentacion_id = params[:alimentacion_id]
        @alimentacion_detalle.descripcion = params[:descripcion].upcase
        @alimentacion_detalle.fecha_suministro = params[:fecha_suministro]
        @alimentacion_detalle.numero_lote = params[:numero_lote]
        @alimentacion_detalle.cantidad_suministro = params[:cantidad_suministro]
        @alimentacion_detalle.costo_suministro = params[:costo_suministro]
        @alimentacion_detalle.observacion = params[:observacion]
        @alimentacion_detalle.fecha_vencimiento = params[:fecha_vencimiento]

        if @alimentacion_detalle.save


          auditoria_nueva("agregar alimentacion detalle", "alimentaciones_detalles", @alimentacion_detalle)

          @alimentacion.cantidad_stock = @alimentacion.cantidad_stock + @alimentacion_detalle.cantidad_suministro
          if @alimentacion.save

            auditoria_despues(@alimentacion, auditoria_id)
            @guardado_ok = true

          end

        end

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_alimentacion_detalle

    @eliminado_ok = false
    @valido = true

    Alimentacion.transaction do

      @alimentacion = Alimentacion.where("id = ?", params[:alimentacion_id]).first
      auditoria_id = auditoria_antes("eliminar suministro alimentacion detalle", "alimentaciones", @alimentacion)

      @alimentacion_detalle = AlimentacionDetalle.where("id = ?", params[:alimentacion_detalle_id]).first
      auditoria_id = auditoria_antes("eliminar suministro alimentacion detalle", "alimentaciones_detalles", @alimentacion_detalle)


      if @valido

        @alimentacion_detalle_elim = @alimentacion_detalle

        if @alimentacion_detalle.destroy

          auditoria_nueva("eliminar alimentacion detalle", "alimentaciones_detalles", @alimentacion_detalle_elim )

          @alimentacion.cantidad_stock = @alimentacion.cantidad_stock - @alimentacion_detalle.cantidad_suministro

          if @alimentacion.save

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
