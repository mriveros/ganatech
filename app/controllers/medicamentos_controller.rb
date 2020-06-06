class MedicamentosController < ApplicationController

  before_filter :require_usuario

  def index
    

  end


  def lista
    cond = []
    args = []

    if params[:form_buscar_medicamento_id].present?

      cond << "medicamento_id = ?"
      args << params[:form_buscar_medicamento_id]

    end

    if params[:form_buscar_medicamento_nombre_medicamento].present?

      cond << "nombre_medicamento  ilike ?"
      args << "%#{params[:form_buscar_medicamento_nombre_medicamento]}%"

    end

    if params[:form_buscar_medicamento_descripcion].present?

      cond << "medicamento  ilike ?"
      args << "%#{params[:form_buscar_medicamento_descripcion]}%"

    end

    if params[:form_buscar_medicamento_cantidad_stock].present?

      cond << "cantidad_stock  = ?"
      args << params[:form_buscar_medicamento_cantidad_stock]

    end

    if params[:form_buscar_medicamento_cantidad_aplicacion].present?

      cond << "cantidad_aplicacion = ?"
      args << params[:form_buscar_medicamento_cantidad_aplicacion]

    end

    if params[:form_buscar_medicamento_ciclo].present?

      cond << "ciclo = ?"
      args << params[:form_buscar_medicamento_ciclo]

    end


    if params[:form_buscar_medicamento_intervalo_tiempo].present?

      cond << "intervalo_tiempo = ?"
      args << params[:form_buscar_medicamento_intervalo_tiempo]

    end

    if params[:form_buscar_medicamento][:estado_medicamento_id].present?

      cond << "estado_medicamento_id = ?"
      args << params[:form_buscar_medicamento][:estado_medicamento_id]

    end

    if params[:form_buscar_medicamento][:tipo_presentacion_id].present?

      cond << "tipo_presentacion_id = ?"
      args <<params[:form_buscar_medicamento][:tipo_presentacion_id]

    end

    if params[:form_buscar_medicamento][:tipo_administracion_id].present?

      cond << "tipo_administracion_id = ?"
      args << params[:form_buscar_medicamento][:tipo_administracion_id]

    end

    if params[:form_buscar_medicamento_fecha_vencimiento].present?

      cond << "fecha_vencimiento = ?"
      args << params[:form_buscar_medicamento_fecha_vencimiento]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @medicamentos =  VMedicamento.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VMedicamento.where(cond).count

    else
     
      @medicamentos = VMedicamento.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VMedicamento.count

    end

    @total_registros = VMedicamento.count

    respond_to do |f|
      
     f.js
      
    end

  end


  def agregar

    @medicamento = Medicamento.new

    respond_to do |f|

      f.js

    end

  end

  def guardar

    valido = true
    @msg = ""
    @guardado_ok = false
    
    @medicamento = Medicamento.new
    @medicamento.descripcion = params[:descripcion].upcase
    @medicamento.nombre_medicamento = params[:nombre_medicamento].upcase
    @medicamento.cantidad_stock = params[:cantidad_stock]
    @medicamento.cantidad_aplicacion = params[:cantidad_aplicacion]
    @medicamento.ciclo = params[:ciclo]
    @medicamento.intervalo_tiempo = params[:intervalo_tiempo]
    @medicamento.observacion = params[:observacion]
    @medicamento.estado_medicamento_id = params[:estado_medicamento][:id]
    @medicamento.tipo_presentacion_id = params[:tipo_presentacion][:id]
    @medicamento.tipo_administracion_id = params[:tipo_administracion][:id]
    @medicamento.fecha_vencimiento = params[:fecha_vencimiento]

    if @medicamento.save

      auditoria_nueva("agregar nuevo medicamento", "medicamentos", @medicamento)
      @guardado_ok = true

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar

    @eliminado = false
    @valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:id])
    
    controles_ganado = ControlGanado.where("medicamento_id = ?", @medicamento.id)

    if controles_ganado.present?

      @msg = "El medicamento ya ha sido utilizado en controles de ganados."
      @valido = false

    end

    if @valido

      @medicamento_elim = @medicamento
      auditoria_nueva("eliminar medicamento", "medicamentos", @medicamento)
      if @medicamento.destroy
        
        @eliminado = true

      end

    end


    respond_to do |f|

      f.js

    end

  end

  def editar

    @medicamento = Medicamento.find(params[:medicamento_id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    @valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:medicamento_id])
    auditoria_id = auditoria_antes("actualizar medicamento", "medicamentos", @medicamento)

    if @valido

      @medicamento.descripcion = params[:medicamento][:descripcion].upcase
      @medicamento.nombre_medicamento = params[:medicamento][:nombre_medicamento].upcase
      @medicamento.cantidad_stock = params[:medicamento][:cantidad_stock]
      @medicamento.cantidad_aplicacion = params[:medicamento][:cantidad_aplicacion]
      @medicamento.ciclo = params[:medicamento][:ciclo]
      @medicamento.intervalo_tiempo = params[:medicamento][:intervalo_tiempo]
      @medicamento.observacion = params[:medicamento][:observacion]
      @medicamento.estado_medicamento_id = params[:medicamento][:estado_medicamento_id]
      @medicamento.tipo_presentacion_id = params[:medicamento][:tipo_presentacion_id]
      @medicamento.tipo_administracion_id = params[:medicamento][:tipo_administracion_id]
      @medicamento.fecha_vencimiento = params[:medicamento][:fecha_vencimiento]

      if @medicamento.save

        auditoria_despues(@medicamento, auditoria_id)
        @medicamento_ok = true

      end

    end
    
    respond_to do |f|

      f.js

    end

  end


  def buscar_medicamento

    @medicamentos = Medicamento.where("nombre_medicamento ilike ?", "%#{params[:medicamento]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @medicamentos }
    
    end

  end

  def medicamento_detalle

    @medicamento_detalle = Medicamento.where("id = ?", params[:medicamento_detalle]).first


     respond_to do |f|

      f.js

    end

  end


  def agregar_medicamento_detalle


    @medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

    respond_to do |f|

      f.js

    end

  end

   def guardar_medicamento_detalle


     respond_to do |f|

      f.js

    end

  end


  def eliminar_medicamento_detalle


     respond_to do |f|

      f.js

    end
    
  end


end