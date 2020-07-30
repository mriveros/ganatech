class GanadosSalidasController < ApplicationController
 
before_filter :require_usuario

  def index
  
 
  end 
  
  def lista

    cond = []
    args = []

    if params[:form_buscar_salida_ganado_id].present?

      cond << "control_ganado_id = ?"
      args << params[:form_buscar_salida_ganado_id]

    end

    if params[:form_buscar_salida_ganado_codigo].present?

      cond << "codigo = ?"
      args << params[:form_buscar_salida_ganado_codigo]

    end

    if params[:form_buscar_salida_ganado_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_salida_ganado_nombre]}%"

    end

    if params[:form_buscar_salida_ganado_ganado_rp].present?

      cond << "ganado_rp  = ?"
      args << params[:form_buscar_salida_ganado_ganado_rp]

    end

    
    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_salidas =  VGanadoSalida.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoSalida.where(cond).count

    else
     
      @ganados_salidas = VGanadoSalida.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoSalida.count

    end

    @total_registros = VGanadoSalida.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @ganado_salida = GanadoSalida.new
    nuevo_incremento = GanadoSalida.last
    @codigo_salida = nuevo_incremento.codigo_lote + 1
    @fecha_actual = Date.today.strftime('%d/%m/%Y')

    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = false
    @msg = ""
    @guardado_ok = false

    
    if @valido
  
      if params[:clasificacion_salida][:id].to_i == PARAMETRO[:clasificacion_salida_por_ganado]
        
        @ganado_salida = GanadoSalida.new
        @ganado_salida.ganado_id = params[:ganado_id]
        @ganado_salida.fecha_control = params[:fecha_control]
        @ganado_salida.control_id = params[:control][:id]
        @ganado_salida.medicamento_id = params[:medicamento_id]
        @ganado_salida.cantidad_suministrada = params[:cantidad_suministrada]
        @ganado_salida.codigo = params[:codigo_lote]
        @ganado_salida.clasificacion_control_id = params[:clasificacion_control][:id]
        @ganado_salida.observacion = params[:observacion]

        if @ganado_salida.save

          @guardado_ok = true

        end

      end


      if params[:clasificacion_salida][:id].to_i == PARAMETRO[:clasificacion_salida_por_lote]
        
        @ganado_lote = LoteSalidaGanado.all

        @ganado_lote.each do |ganado|

          @ganado_salida = GanadoSalida.new
          
          @ganado_salida.ganado_id = ganado.ganado_id
          @ganado_salida.fecha_control = params[:fecha_control]
          @ganado_salida.control_id = params[:control][:id]
          @ganado_salida.medicamento_id = params[:medicamento_id]
          @ganado_salida.cantidad_suministrada = params[:cantidad_suministrada]
          @ganado_salida.codigo = params[:codigo_lote]
          @ganado_salida.clasificacion_control_id = params[:clasificacion_control][:id]
          @ganado_salida.observacion = params[:observacion]

          if @ganado_salida.save

            @guardado_ok = true

          end

        end
        #Borrar toda la tabla
        LoteSalidaGanado.destroy_all

      end


    end


     respond_to do |f|

      f.js

    end
  
  end

 
 def eliminar

    @eliminado = false
    @msg = ""

    @control_ganado = ControlGanado.where("id = ?", params[:control_ganado_id]).first
    @control_ganado_elim = @control_ganado
    
    if @control_ganado.destroy
    
      @eliminado = true

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


  def seleccionar_lote

    @lote = LoteControlGanado.new

    respond_to do |f|

      f.js

    end

  end


  def eliminar_lote

    @lote_eliminado = false

    @lote_control_ganado = ControlGanado.where("codigo = ?", params[:codigo_lote])

    if @lote_control_ganado.destroy_all

      @lote_eliminado = true

    end

    respond_to do |f|

      f.js

    end


  end


  def buscar_cliente
    
    @cliente = Cliente.where("nombre_razon_social ilike ?", "%#{params[:cliente]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @cliente }
    
    end
    
  end


end