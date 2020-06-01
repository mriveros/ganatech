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
    @medicamento_ok = false
                  
    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:id])
        
    respond_to do |f|

      f.js

    end

  end

  def editar

    @medicamento = Medicamento.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:medicamento][:id])
    auditoria_id = auditoria_antes("actualizar medicamento", "medicamentos", @medicamento)

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

end