class ControlesAlimentacionesController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_control_alimentacion_id].present?

      cond << "control_alimentacion_id = ?"
      args << params[:form_buscar_control_alimentacion_id]

    end

    if params[:form_buscar_control_alimentacion_codigo].present?

      cond << "codigo_lote = ?"
      args << params[:form_buscar_control_alimentacion_codigo]

    end

    if params[:form_buscar_control_alimentacion_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_control_alimentacion_nombre]}%"

    end

    if params[:form_buscar_control_alimentacion_ganado_rp].present?

      cond << "ganado_rp  ilike ?"
      args << "%#{params[:form_buscar_control_alimentacion_ganado_rp]}%"

    end

    if params[:form_buscar_control_alimentacion][:tipo_alimentacion_id].present?

      cond << "tipo_alimentacion_id = ?"
      args << params[:form_buscar_control_alimentacion][:tipo_alimentacion_id]

    end

    if params[:form_buscar_control_alimentacion][:alimentacion_id].present?

      cond << "alimentacion_id = ?"
      args << params[:form_buscar_control_alimentacion][:alimentacion_id]

    end

    if params[:form_buscar_control_alimentacion_cantidad_suministrada].present?

      cond << "cantidad_suministrada  = ?"
      args << params[:form_buscar_control_alimentacion_cantidad_suministrada]

    end

    if params[:form_buscar_control_alimentacion_peso].present?

      cond << "peso = ?"
      args << params[:form_buscar_control_alimentacion_peso]

    end

    if params[:form_buscar_control_alimentacion_fecha_control].present?

      cond << "fecha_control = ?"
      args << params[:form_buscar_control_alimentacion_fecha_control]

    end

    if params[:form_buscar_control_alimentacion_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_control_alimentacion_observacion]}%"

    end

    if params[:form_buscar_control_alimentacion][:clasificacion_alimentacion_id].present?

      cond << "clasificacion_alimentacion_id = ?"
      args << params[:form_buscar_control_alimentacion][:clasificacion_alimentacion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @controles_alimentaciones =  VControlAlimentacion.orden_fecha.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VControlAlimentacion.where(cond).count

    else
     
      @controles_alimentaciones = VControlAlimentacion.orden_fecha.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VControlAlimentacion.count

    end

    @total_registros = VControlAlimentacion.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @control_alimentacion = ControlAlimentacion.new
    nuevo_incremento = ControlAlimentacion.last
    if nuevo_incremento.present?

      @codigo_control = nuevo_incremento.codigo_lote + 1

    else

      @codigo_control = 1

    end
    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = " "
    @guardado_ok = false

    

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        
        alimento = Alimentacion.where("id = ?", params[:alimentacion_id]).first

        if alimento.cantidad_stock < params[:cantidad_suministrada].to_i

          @msg = "No hay suficiente Stock para aplicar este alimento. "
          @valido = false

        end

      end

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_potrero]
        
        @ganado_potrero = VGanado.modulo_control_alimento.where("potrero_id = ?", params[:potrero][:id])
        alimento = Alimentacion.where("id = ?", params[:alimentacion_id]).first

        if alimento.cantidad_stock < (params[:cantidad_suministrada].to_i * @ganado_potrero.size.to_i)

          @msg = "No hay suficiente Stock para aplicar este alimento. "
          @valido = false

        end

      end

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_hacienda]
        
        @ganado_hacienda =VGanado.modulo_control_alimento.where("hacienda_id = ?", params[:hacienda_select][:id])
        alimento = Alimentacion.where("id = ?", params[:alimentacion_id]).first

        if alimento.cantidad_stock < (params[:cantidad_suministrada].to_i * @ganado_hacienda.size.to_i)

          @msg = "No hay suficiente Stock para aplicar este alimento. "
          @valido = false

        end

      end


      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_lote]
        
        @ganado_lote =LoteControlAlimentacion.all
        alimento = Alimentacion.where("id = ?", params[:alimentacion_id]).first

        if alimento.cantidad_stock < (params[:cantidad_suministrada].to_i * @ganado_lote.size.to_i)

          @msg = "No hay suficiente Stock para aplicar este alimento. "
          @valido = false

        end

      end

    


    
    if @valido

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        
        @alimentacion = ControlAlimentacion.new
        @alimentacion.ganado_id = params[:ganado_id]
        @alimentacion.fecha_control = params[:fecha_control]
        @alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
        @alimentacion.alimentacion_id = params[:alimentacion_id]
        @alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
        @alimentacion.codigo_lote = params[:codigo_lote]
        @alimentacion.clasificacion_alimentacion_id = params[:clasificacion_alimentacion][:id]
        @alimentacion.observacion = params[:observacion]

        if @alimentacion.save
 
          @guardado_ok = true

          #AGREGAR HISTORIAL GANADO
          historial_ganado = HistorialGanado.new
          historial_ganado.ganado_id = params[:ganado_id]
          historial_ganado.modulo = "CONTROLES ALIMENTACION"
          historial_ganado.accion = "Alimentaciones"
          historial_ganado.fecha = params[:fecha_control]
          historial_ganado.control_alimentacion_id = @alimentacion.id
          historial_ganado.observacion = params[:observacion]
          historial_ganado.save

        end

      end

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_potrero]
        
        if @ganado_potrero.present?
        
          @ganado_potrero.each do |ganado|

            @alimentacion = ControlAlimentacion.new
            @alimentacion.ganado_id = ganado.id
            @alimentacion.fecha_control = params[:fecha_control]
            @alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
            @alimentacion.alimentacion_id = params[:alimentacion_id]
            @alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
            @alimentacion.codigo_lote = params[:codigo_lote]
            @alimentacion.clasificacion_alimentacion_id = params[:clasificacion_alimentacion][:id]
            @alimentacion.observacion = params[:observacion]

            if @alimentacion.save

              @guardado_ok = true

              #AGREGAR HISTORIAL GANADO
              historial_ganado = HistorialGanado.new
              historial_ganado.ganado_id = ganado.id
              historial_ganado.modulo = "CONTROLES ALIMENTACION"
              historial_ganado.accion = "Alimentaciones"
              historial_ganado.fecha = params[:fecha_control]
              historial_ganado.control_alimentacion_id = @alimentacion.id
              historial_ganado.observacion = params[:observacion]
              historial_ganado.save

            end

          end
        
        else

          @msg = ' No hay Ganados en este Potrero.'

        end

      end


      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_hacienda]
        
        if @ganado_hacienda.present?

          @ganado_hacienda.each do |ganado|

            @alimentacion = ControlAlimentacion.new
            @alimentacion.ganado_id = ganado.id
            @alimentacion.fecha_control = params[:fecha_control]
            @alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
            @alimentacion.alimentacion_id = params[:alimentacion_id]
            @alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
            @alimentacion.codigo_lote = params[:codigo_lote]
            @alimentacion.clasificacion_alimentacion_id = params[:clasificacion_alimentacion][:id]
            @alimentacion.observacion = params[:observacion]

            if @alimentacion.save

              @guardado_ok = true

              #AGREGAR HISTORIAL GANADO
              historial_ganado = HistorialGanado.new
              historial_ganado.ganado_id = ganado.id
              historial_ganado.modulo = "CONTROLES ALIMENTACION"
              historial_ganado.accion = "Alimentaciones"
              historial_ganado.fecha = params[:fecha_control]
              historial_ganado.control_alimentacion_id = @alimentacion.id
              historial_ganado.observacion = params[:observacion]
              historial_ganado.save

            end

          end
        else

          @msg = ' No hay Ganados en esta Hacienda.'

        end

      end


      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_lote]
        if @ganado_lote.present?
          
          @ganado_lote.each do |ganado|

            @alimentacion = ControlAlimentacion.new
            @alimentacion.ganado_id = ganado.ganado_id
            @alimentacion.fecha_control = params[:fecha_control]
            @alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
            @alimentacion.alimentacion_id = params[:alimentacion_id]
            @alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
            @alimentacion.codigo_lote = params[:codigo_lote]
            @alimentacion.clasificacion_alimentacion_id = params[:clasificacion_alimentacion][:id]
            @alimentacion.observacion = params[:observacion]

            if @alimentacion.save

              @guardado_ok = true

              #AGREGAR HISTORIAL GANADO
              historial_ganado = HistorialGanado.new
              historial_ganado.ganado_id = ganado.id
              historial_ganado.modulo = "CONTROLES ALIMENTACION"
              historial_ganado.accion = "Alimentaciones"
              historial_ganado.fecha = params[:fecha_control]
              historial_ganado.control_alimentacion_id = @alimentacion.id
              historial_ganado.observacion = params[:observacion]
              historial_ganado.save

            end

          end
        
        else

          @msg = ' No hay Ganados seleccionados en el Lote.'

        end
        #Borrar toda la tabla
        LoteControlAlimentacion.destroy_all

      end


    end


     respond_to do |f|

      f.js

    end
  
  end

 
 def eliminar

    @eliminado = false
    @msg = ""

    @alimentacion = ControlAlimentacion.where("id = ?", params[:control_alimentacion_id]).first
    @alimentacion_elim = @alimentacion
    
    #ELIMINAR HISTORIAL GANADO
    historial_ganado = HistorialGanado.where("control_alimentacion_id = ?",@alimentacion.id).first
    historial_ganado.destroy

    if @alimentacion.destroy
    
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

      cond << "rp ilike ?"
      args << "%#{params[:form_buscar_ganado_rp]}%"

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

      @ganados =  VGanado.modulo_control_alimento.orden_01.where(cond).paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.modulo_control_alimento.where(cond).count

    else
     
      @ganados = VGanado.modulo_control_alimento.orden_01.paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.modulo_control_alimento.count

    end

    @total_registros = VGanado.modulo_control_alimento.count


    respond_to do |f|

      f.js

    end

  end


  def agregar_ganado_lote

    @lote_alimentacion = LoteControlAlimentacion.new
    @lote_alimentacion.ganado_id = params[:ganado_id]
    
    if @lote_alimentacion.save

      auditoria_nueva("Guardar Lote para control de alimentacion ganado","tmp_ganados_alimentaciones_lotes", @lote_alimentacion)

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_ganado_lote

    @lote_alimentacion = LoteControlAlimentacion.where("ganado_id = ? ", params[:ganado_id]).first
    aux = @lote_alimentacion 
    
    if @lote_alimentacion.destroy
    
      auditoria_nueva("Eliminar Lote para control de alimentacion de ganado","tmp_ganados_alimentaciones_lotes", @lote_alimentacion)

    end

    respond_to do |f|

      f.js

    end

  end


  def buscar_ganado

    @ganados = VGanado.modulo_control_alimento.where("nombre ilike (?) ", "%#{params[:ganado]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


  def seleccionar_lote

    @lote = LoteControlAlimentacion.new

    respond_to do |f|

      f.js

    end

  end


  def eliminar_lote

    @lote_eliminado = false

    @lote_alimentacion = ControlAlimentacion.where("codigo_lote = ?", params[:codigo_lote])

    @lote_alimentacion.each do |lca|
      
      #ELIMINAR HISTORIAL GANADO
      historial_ganado = HistorialGanado.where("control_alimentacion_id = ?",lca.id).first
      historial_ganado.destroy

    end

    if @lote_alimentacion.destroy_all

      @lote_eliminado = true

    end

    respond_to do |f|

      f.js

    end


  end


end