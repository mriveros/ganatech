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

    if params[:form_buscar_medicamento_costo].present?

      cond << "costo  = ?"
      args << params[:form_buscar_medicamento_costo]

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

    MedicamentoDetalle.transaction do
    
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
      @medicamento.costo = params[:costo].to_s.gsub(/[$.]/,'').to_i

      if @medicamento.save

        auditoria_nueva("agregar nuevo medicamento", "medicamentos", @medicamento)
        @medicamento_detalle = MedicamentoDetalle.new
        @medicamento_detalle.medicamento_id = @medicamento.id
        @medicamento_detalle.descripcion = @medicamento.descripcion
        @medicamento_detalle.fecha_suministro = Date.today
        @medicamento_detalle.numero_lote = 0
        @medicamento_detalle.cantidad_suministro = @medicamento.cantidad_stock
        @medicamento_detalle.costo_suministro = params[:costo].to_s.gsub(/[$.]/,'').to_i
        @medicamento_detalle.observacion = @medicamento.observacion
        @medicamento_detalle.fecha_vencimiento = @medicamento.fecha_vencimiento 
        @medicamento_detalle.costo_total = (@medicamento.cantidad_stock.to_i * params[:costo].to_s.gsub(/[$.]/,'').to_i)

        if @medicamento_detalle.save
          
          @guardado_ok = true
          
          @compra = AuxCompra.new
          @compra.fecha = Date.today
          @compra.descripcion = "Compra Medicamento: #{@medicamento.nombre_medicamento}"
          @compra.observacion = @medicamento.observacion
          @compra.monto = @medicamento_detalle.costo_total
          @compra.medicamento_detalle_id = @medicamento_detalle.id
          @compra.save

        end

      end

    end #transaction

    respond_to do |f|

      f.js

    end

  end

  def eliminar

    @eliminado = false
    @valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:id])

    @medicamento_detalle = MedicamentoDetalle.where("medicamento_id = ?", params[:id])
    
    controles_ganado = ControlGanado.where("medicamento_id = ?", @medicamento.id)

    if controles_ganado.present?

      @msg = "El medicamento ya ha sido utilizado en controles de ganados."
      @valido = false

    end

    if @medicamento_detalle.present?

      @msg += "El medicamento ya cuenta con suministros."
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
      @medicamento.costo = params[:medicamento][:costo].to_s.gsub(/[$.]/,'').to_i
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

    @medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

    @medicamento_detalle = MedicamentoDetalle.orden_date.where("medicamento_id = ?", params[:medicamento_id]).paginate(per_page: 5, page: params[:page])


     respond_to do |f|

      f.js

    end

  end


  def agregar_medicamento_detalle


    @medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

    ultima_produccion = Medicamento.order("created_at").last
    @numero_lote = ultima_produccion.id + 1

    respond_to do |f|

      f.js

    end

  end

   def guardar_medicamento_detalle

    @guardado_ok = false
    @valido = true

    Medicamento.transaction do

      @medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first 
      auditoria_id = auditoria_antes("guardar suministro medicamento detalle", "medicamentos", @medicamento)

      if @valido

        @medicamento_detalle = MedicamentoDetalle.new
        @medicamento_detalle.medicamento_id = params[:medicamento_id]
        @medicamento_detalle.descripcion = params[:descripcion].upcase
        @medicamento_detalle.fecha_suministro = params[:fecha_suministro]
        @medicamento_detalle.numero_lote = params[:numero_lote]
        @medicamento_detalle.cantidad_suministro = params[:cantidad_suministro]
        @medicamento_detalle.costo_suministro = params[:costo_suministro].to_s.gsub(/[$.]/,'').to_i
        @medicamento_detalle.observacion = params[:observacion]
        @medicamento_detalle.fecha_vencimiento = params[:fecha_vencimiento]
        @medicamento_detalle.costo_total = (params[:cantidad_suministro].to_i * params[:costo_suministro].to_s.gsub(/[$.]/,'').to_i)

        if @medicamento_detalle.save

          auditoria_nueva("agregar medicamento detalle", "medicamentos_detalles", @medicamento_detalle)

          @medicamento.cantidad_stock = @medicamento.cantidad_stock + @medicamento_detalle.cantidad_suministro
          
          if @medicamento.save

            auditoria_despues(@medicamento, auditoria_id)
            @guardado_ok = true

            @compra = AuxCompra.new
            @compra.fecha = params[:fecha_suministro]
            @compra.descripcion = "Compra Suministro Medicamento: #{@medicamento.nombre_medicamento}"
            @compra.observacion = params[:observacion]
            @compra.monto = @medicamento_detalle.costo_total
            @compra.medicamento_detalle_id = @medicamento_detalle.id
            @compra.save

          end

        end

      end

    end

    respond_to do |f|

      f.js

    end

  end


  def eliminar_medicamento_detalle

    @eliminado_ok = false
    @valido = true

    Medicamento.transaction do

      @medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first 
      auditoria_id = auditoria_antes("eliminar suministro medicamento detalle", "medicamentos", @medicamento)

      @medicamento_detalle = MedicamentoDetalle.where("id = ?", params[:medicamento_detalle_id]).first 
      auditoria_id = auditoria_antes("eliminar suministro medicamento detalle", "medicamentos_detalles", @medicamento_detalle)

      @compra = AuxCompra.where("medicamento_detalle_id = ?", @medicamento_detalle.id).first
      @compra.destroy

      if @valido

        @medicamento_detalle_elim = @medicamento_detalle

        if @medicamento_detalle.destroy

          auditoria_nueva("eliminar medicamento detalle", "medicamentos_detalles", @medicamento_detalle_elim )

          @medicamento.cantidad_stock = @medicamento.cantidad_stock - @medicamento_detalle.cantidad_suministro
          
          if @medicamento.save

            @eliminado_ok = true

          end

        end

      end

    end

    respond_to do |f|

      f.js

    end
    
  end



  def dar_baja_medicamento

    @actualizado_ok = false
    @valido = true

    Medicamento.transaction do

      @medicamento = Medicamento.where('id = ?', params[:medicamento_id]).first

    end

    respond_to do |f|

      f.js

    end
    
  end


end