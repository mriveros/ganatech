class ControlesGanadosController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_control_ganado_id].present?

      cond << "control_ganado_id = ?"
      args << params[:form_buscar_control_ganado_id]

    end

    if params[:form_buscar_control_ganado_codigo].present?

      cond << "codigo = ?"
      args << params[:form_buscar_control_ganado_codigo]

    end

    if params[:form_buscar_control_ganado_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_control_ganado_nombre]}%"

    end

    if params[:form_buscar_control_ganado_ganado_rp].present?

      cond << "ganado_rp  = ?"
      args << params[:form_buscar_control_ganado_ganado_rp]

    end

    if params[:form_buscar_control_ganado][:control_id].present?

      cond << "control_id = ?"
      args << params[:form_buscar_control_ganado][:control_id]

    end

    if params[:form_buscar_control_ganado][:medicamento_id].present?

      cond << "medicamento_id = ?"
      args << params[:form_buscar_control_ganado][:medicamento_id]

    end

    if params[:form_buscar_control_ganado_cantidad_suministrada].present?

      cond << "cantidad_suministrada  = ?"
      args << params[:form_buscar_control_ganado_cantidad_suministrada]

    end

    if params[:form_buscar_control_ganado_peso].present?

      cond << "peso = ?"
      args << params[:form_buscar_control_ganado_peso]

    end

    if params[:form_buscar_control_ganado_fecha_control].present?

      cond << "fecha_control = ?"
      args << params[:form_buscar_control_ganado_fecha_control]

    end

    if params[:form_buscar_control_ganado_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_control_ganado_observacion]}%"

    end

    if params[:form_buscar_control_ganado][:clasificacion_control_id].present?

      cond << "clasificacion_control_id = ?"
      args << params[:form_buscar_control_ganado][:clasificacion_control_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @controles_ganados =  VControlGanado.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VControlGanado.where(cond).count

    else
     
      @controles_ganados = VControlGanado.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VControlGanado.count

    end

    @total_registros = VControlGanado.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @control_ganado = ControlGanado.new
    nuevo_incremento = ControlGanado.last
    @codigo_control = nuevo_incremento.id + 1

    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = " "
    @guardado_ok = false

    if params[:clasificacion_control][:id] == PARAMETRO[:clasificacion_por_ganado]
      
      medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first
      if medicamento.cantidad_stock < params[:cantidad_suministrada]

        @msg = "No hay suficiente Stock para aplicar este medicamento. "
        @valido = true

      end

    end
    
    if @valido

      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        puts "DEBUG!"
        @control_ganado = ControlGanado.new
        @control_ganado.ganado_id = params[:ganado_id]
        @control_ganado.fecha_control = params[:fecha_control]
        @control_ganado.control_id = params[:control][:id]
        @control_ganado.medicamento_id = params[:medicamento_id]
        @control_ganado.cantidad_suministrada = params[:cantidad_suministrada]
        @control_ganado.codigo = params[:codigo_lote]
        @control_ganado.clasificacion_control_id = params[:clasificacion_control][:id]
        @control_ganado.observacion = params[:observacion]

        if @control_ganado.save

          @guardado_ok = true

        end

      end

      

    end


     respond_to do |f|

      f.js

    end
  
  end

  def editar
    
    @control_ganado = ControlGanado.find(params[:celo_id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

    @valido = true
    @msg = ""
    @guardado_ok = false

               

    respond_to do |f|

      f.js

    end
  
  end


 def eliminar

    valido = true
    @msg = ""

   
    
    rescue Exception => exc  
      
      if exc.present?        
      
        @excep = exc.message.split(':')    
        @msg = "El celo contiene datos relacionados."
        @eliminado = false
      
      end
        
    respond_to do |f|

      f.js

    end

  end


  def crear_lote_ganado

    respond_to do |f|

      f.js

    end

  end


  def lista_ganado
    
    cond = []
    args = []
    
    if params[:form_buscar_ganado_nombre].present?

      cond << "nombre ilike ?"
      args << "%#{params[:form_buscar_ganado_nombre]}%"

    end

    if params[:form_buscar_ganado_rp].present?

      cond << "rp = ?"
      args << params[:form_buscar_ganado_rp]

    end

    if params[:form_buscar_ganado_codigo_rfid].present?

      cond << "codigo_rfid = ?"
      args << params[:form_buscar_ganado_codigo_rfid]

    end

    if params[:form_buscar_ganado_hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_ganado_hacienda_id]

    end

    if params[:form_buscar_ganado_potrero_id].present?

      cond << "potrero_id = ?"
      args << params[:form_buscar_ganado_potrero_id]

    end

    if params[:form_buscar_ganado_estado_ganado_id].present?

      cond << "estado_ganado_id = ?"
      args << params[:form_buscar_ganado_estado_ganado_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados =  VGanado.orden_01.where(cond).paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.where(cond).count

    else
     
      @ganados = VGanado.orden_01.paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.count

    end

    @total_registros = VGanado.count


    respond_to do |f|

      f.js

    end

  end


  def agregar_ganado_lote

    @lote_control_ganado = LoteControlGanado.new
    @lote_control_ganado.ganado_id = params[:ganado_id]
    
    if @lote_control_ganado.save

      auditoria_nueva("Guardar Lote para control de ganado","tmp_ganados_controles_lotes", @lote_control_ganado)

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_ganado_lote

    @lote_control_ganado = LoteControlGanado.where("ganado_id = ? ", params[:ganado_id]).first
    aux = @lote_control_ganado 
    
    if @lote_control_ganado.destroy
    
      auditoria_nueva("Eliminar Lote para control de ganado","tmp_ganados_controles_lotes", @lote_control_ganado)

    end

    respond_to do |f|

      f.js

    end

  end


  def buscar_ganado

    @ganados = VGanado.where("nombre ilike (?) ", "%#{params[:ganado]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end
  end



end