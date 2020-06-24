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

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

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

=begin
    if params[:form_buscar_ganado][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_ganado][:hacienda_id]

    end


    if params[:form_buscar_ganado][:potrero_id].present?

      cond << "potrero_id = ?"
      args << params[:form_buscar_ganado][:potrero_id]

    end
=end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados =  VGanado.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanado.where(cond).count

    else
     
      @ganados = VGanado.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanado.count

    end

    @total_registros = VGanado.count

    respond_to do |f|
      
     f.js
      
    end

  end


end