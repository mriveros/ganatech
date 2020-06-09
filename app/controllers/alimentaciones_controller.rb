class AlimentacionesController < ApplicationController

before_filter :require_usuario

  def index

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_alimentaciones_id].present?

      cond << "id = ?"
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

      cond << "estado_alimento ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_estado_alimento]}%"

    end


    if params[:form_buscar_alimentaciones_tipo_alimentacion_id].present?

      cond << "tipo_alimento ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_tipo_alimento]}%"

    end


    if params[:form_buscar_alimentaciones_fecha_vencimiento].present?

      cond << "fecha_vencimiento ilike ?"
      args << "%#{params[:form_buscar_alimentaciones_fecha_vencimiento]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @alimentaciones =  Alimentacion.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = Alimentacion.where(cond).count

    else

      @alimentaciones = Alimentacion.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Alimentacion.count

    end

    @total_registros = Alimentacion.count

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

    @alimento = Alimentacion.new()

    @alimento.descripcion = params[:alimentacion][:descripcion].upcase
    @alimento.nombre_alimento = params[:nombre_alimento].upcase
    @alimento.cantidad_stock = params[:cantidad_stock]
    @alimento.cantidad_aplicacion = params[:cantidad_aplicacion]
    @alimento.ciclo = params[:ciclo]
    @alimento.intervalo_tiempo = params[:intervalo_tiempo]
    @alimento.observacion = params[:observacion]
    @alimento.estado_alimento_id = params[:estado_alimento][:id]
    @alimento.tipo_presentacion_id = params[:tipo_presentacion][:id]
    @alimento.tipo_administracion_id = params[:tipo_administracion][:id]
    @alimento.fecha_vencimiento = params[:fecha_vencimiento]

    if @alimento.save

      auditoria_nueva("registrar alimentacion", "alimentaciones", @alimento)
      @alimento_ok = true

    end

    rescue Exception => exc
      # dispone el mensaje de error
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?
        @excep = exc.message.split(':')
        @msg = @excep[3].concat(" "+@excep[4].to_s)

      end


    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @alimento = Alimentacion.find(params[:id])

    @alimento_elim = @alimento

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
        @excep = exc.message.split(':')
        @msg = @excep[3].concat(" "+@excep[4])
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

    @alimento = Alimentacion.find(params[:alimento][:id])
    auditoria_id = auditoria_antes("actualizar alimento", "alimentos", @alimento)

    if valido

      @alimento.descripcion = params[:alimento][:descripcion].upcase
      @alimento.nombre_alimento = params[:alimento][:nombre_alimento].upcase
      @alimento.cantidad_stock = params[:alimento][:cantidad_stock]
      @alimento.cantidad_aplicacion = params[:alimento][:cantidad_aplicacion]
      @alimento.ciclo = params[:alimento][:ciclo]
      @alimento.intervalo_tiempo = params[:alimento][:intervalo_tiempo]
      @alimento.observacion = params[:alimento][:observacion]
      @alimento.estado_medicamento_id = params[:alimento][:estado_medicamento_id]
      @alimento.tipo_presentacion_id = params[:alimento][:tipo_presentacion_id]
      @alimento.tipo_administracion_id = params[:alimento][:tipo_administracion_id]
      @alimento.fecha_vencimiento = params[:alimento][:fecha_vencimiento]

      if @alimento.save

        auditoria_despues(@alimento, auditoria_id)
        @alimento_ok = true

      end

    end
    rescue Exception => exc
      # dispone el mensaje de error
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?

        @excep = exc.message.split(':')
        @msg = @excep[3].concat(" "+@excep[4])

      end

     respond_to do |f|

      f.js

    end

  end


  def buscar_alimentacion

    if params[:tipo_alimentacion].present?

      @alimentaciones = Alimentacion.where("nombre_alimento ilike ? and tipo_alimentacion_id = ?", "%#{params[:alimentacion]}%", params[:tipo_alimentacion])

    end

    respond_to do |f|

      f.html
      f.json { render :json => @alimentaciones }

    end

  end


end
