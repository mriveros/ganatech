class GanadosSalidasController < ApplicationController
 
before_filter :require_usuario

  def index
  
 
  end 
  
  def lista

    cond = []
    args = []

    if params[:form_buscar_salida_ganado_id].present? 

      cond << "ganado_salida_id = ?"
      args << params[:form_buscar_salida_ganado_id]

    end

    if params[:form_buscar_salida_ganado_fecha_salida].present?

      cond << "fecha_salida = ?"
      args << params[:form_buscar_salida_ganado_fecha_salida]

    end

    if params[:form_buscar_salida_ganado_codigo].present?

      cond << "codigo_rfid = ?"
      args << params[:form_buscar_salida_ganado_codigo]

    end

    if params[:form_buscar_salida_ganado_nombre].present?

      cond << "nombre ilike ?"
      args << "%#{params[:form_buscar_salida_ganado_nombre]}%"

    end

    if params[:form_buscar_salida_ganado_rp].present?

      cond << "rp ilike ?"
      args << "%#{params[:form_buscar_salida_ganado_rp]}%"

    end

    if params[:form_buscar_salida_ganado][:sexo_ganado_id].present?

      cond << "sexo_ganado_id = ?"
      args << params[:form_buscar_salida_ganado][:sexo_ganado_id]

    end

    if params[:form_buscar_salida_ganado][:raza_ganado_id].present?

      cond << "raza_ganado_id = ?"
      args << params[:form_buscar_salida_ganado][:raza_ganado_id]

    end


    if params[:form_buscar_salida_ganado][:etapa_ganado_id].present?

      cond << "etapa_ganado_id = ?"
      args << params[:form_buscar_salida_ganado][:etapa_ganado_id]

    end


    if params[:form_buscar_salida_ganado_ganado_peso_promedio].present?

      cond << "ganado_peso_promedio = ?"
      args << params[:form_buscar_salida_ganado_ganado_peso_promedio]

    end

    if params[:form_buscar_salida_ganado][:tipo_salida_id].present?

      cond << "tipo_salida_id = ?"
      args << params[:form_buscar_salida_ganado][:tipo_salida_id]

    end

    if params[:form_buscar_salida_ganado_precio_venta].present?

      cond << "precio_venta = ?"
      args << params[:form_buscar_salida_ganado_precio_venta]

    end

    if params[:form_buscar_salida_ganado_peso_salida].present?

      cond << "peso_promedio = ?"
      args << params[:form_buscar_salida_ganado_peso_salida]

    end

    if params[:form_buscar_salida_ganado_cliente].present?

      cond << "razon_social ilike ?"
      args << "%#{params[:form_buscar_salida_ganado_cliente]}%"

    end

    if params[:form_buscar_salida_ganado][:estado_movimiento_id].present?

      cond << "estado_movimiento_id = ?"
      args << params[:form_buscar_salida_ganado][:estado_movimiento_id]

    end

    if params[:form_buscar_salida_ganado_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_salida_ganado_observacion]}%"

    end

    if params[:form_buscar_salida_ganado_codigo_lote].present?

      cond << "codigo_lote = ?"
      args << params[:form_buscar_salida_ganado_codigo_lote]

    end

    
    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_salidas =  VGanadoSalida.fecha_salida.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoSalida.where(cond).count

    else
     
      @ganados_salidas = VGanadoSalida.fecha_salida.paginate(per_page: 10, page: params[:page])
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
    
    if nuevo_incremento.present?

      @codigo_salida = nuevo_incremento.codigo_lote + 1

    else

      @codigo_salida = 1

    end
    
    @fecha_actual = Date.today.strftime('%d/%m/%Y')

    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    if @valido
      
      GanadoSalida.transaction do

        if params[:clasificacion_salida][:id].to_i == PARAMETRO[:clasificacion_salida_por_ganado]
          
          @ganado_salida = GanadoSalida.new
          @ganado_salida.peso_promedio = params[:peso_promedio]
          @ganado_salida.ganado_id = params[:ganado_id]
          @ganado_salida.tipo_salida_id = params[:tipo_salida][:id]
          @ganado_salida.precio_venta = params[:precio_venta].to_s.gsub(/[$.]/,'').to_i
          @ganado_salida.observacion = params[:observacion]
          @ganado_salida.estado_movimiento_id = PARAMETRO[:estado_movimiento_en_proceso]
          @ganado_salida.cliente_id = params[:cliente_id]
          @ganado_salida.codigo_lote = params[:codigo_lote]
          @ganado_salida.clasificacion_salida_id = params[:clasificacion_salida][:id]
          @ganado_salida.fecha_salida = params[:fecha_salida]

          if @ganado_salida.save

            auditoria_nueva("Guardar salida de Ganado","ganados_salidas", @ganado_salida)
            @ganado = Ganado.where("id = ?", params[:ganado_id]).first
            auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida", "ganados", @ganado)
            @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_en_proceso_venta]
              
            if @ganado.save

              auditoria_despues(@ganado, auditoria_id)

            end

            @guardado_ok = true
            
            @venta = AuxVenta.new
            @venta.fecha = params[:fecha_salida]
            @venta.descripcion = "SALIDA DE GANADOS: Venta de Ganado"
            @venta.monto = params[:precio_venta].to_s.gsub(/[$.]/,'').to_i
            @venta.observacion = params[:observacion]
            @venta.ganado_salida_lote = params[:codigo_lote]
            @venta.ganado_salida_id = @ganado_salida.id
            @venta.save

          end

        end

        if params[:clasificacion_salida][:id].to_i == PARAMETRO[:clasificacion_salida_por_lote]
          
          @ganado_lote = LoteSalidaGanado.all

          @ganado_lote.each do |ganado|

            @ganado_salida = GanadoSalida.new
            @ganado_salida.peso_promedio = params[:peso_promedio]
            @ganado_salida.ganado_id =  ganado.ganado_id
            @ganado_salida.tipo_salida_id = params[:tipo_salida][:id]
            @ganado_salida.precio_venta = params[:precio_venta].to_s.gsub(/[$.]/,'').to_i
            @ganado_salida.observacion = params[:observacion]
            @ganado_salida.estado_movimiento_id = PARAMETRO[:estado_movimiento_en_proceso]
            @ganado_salida.cliente_id = params[:cliente_id]
            @ganado_salida.codigo_lote = params[:codigo_lote]
            @ganado_salida.clasificacion_salida_id = params[:clasificacion_salida][:id]
            @ganado_salida.fecha_salida = params[:fecha_salida]

            if @ganado_salida.save

              auditoria_nueva("Guardar salida de Ganado","ganados_salidas", @ganado_salida)

              @ganado = Ganado.where("id = ?", ganado.ganado_id).first
              auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida", "ganados", @ganado)
              @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_en_proceso_venta]
              if @ganado.save

                auditoria_despues(@ganado, auditoria_id)

              end

              @guardado_ok = true


            end

          end
          @cantidad_lote = LoteSalidaGanado.count
          #Borrar toda la tabla
          LoteSalidaGanado.destroy_all
          @venta = AuxVenta.new
          @venta.fecha = params[:fecha_salida]
          @venta.descripcion = "SALIDA DE GANADOS: Venta de Ganado CODIGO: #{params[:codigo_lote]} "
          @venta.monto = params[:precio_venta].to_s.gsub(/[$.]/,'').to_i *  @cantidad_lote
          @venta.observacion = params[:observacion]
          @venta.ganado_salida_lote = params[:codigo_lote]
          @venta.save

        end

      end

    end


     respond_to do |f|

      f.js

    end
  
  end

 
 def eliminar_salida_ganado

    @eliminado = false
    @msg = ""

    Ganado.transaction do

      @ganado_salida = GanadoSalida.where("id = ?", params[:id]).first
      @ganado_salida_elim = @ganado_salida
      
      @venta = AuxVenta.where("ganado_salida_lote = ?", @ganado_salida.codigo_lote).first
      @venta.monto = @venta.monto - @ganado_salida.precio_venta
      @venta.save

      if @ganado_salida.destroy
        
        auditoria_nueva("Eliminar salida de Ganado","ganados_salidas", @ganado_salida_elim)
        @ganado = Ganado.where("id = ?", @ganado_salida_elim.ganado_id).first
        auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida", "ganados", @ganado)
        @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
        
        if @ganado.save

          auditoria_despues(@ganado, auditoria_id)
          @eliminado = true

        end
        

      end

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

      @ganados =  VGanado.modulo_ganado_salida.orden_01.where(cond).paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.modulo_ganado_salida.where(cond).count

    else
     
      @ganados = VGanado.modulo_ganado_salida.orden_01.paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.modulo_ganado_salida.count

    end

    @total_registros = VGanado.modulo_ganado_salida.count


    respond_to do |f|

      f.js

    end

  end


  def agregar_ganado_lote

    @lote_control_ganado = LoteSalidaGanado.new
    @lote_control_ganado.ganado_id = params[:ganado_id]
    
    if @lote_control_ganado.save

      auditoria_nueva("Guardar Lote para para salida de ganado","tmp_ganados_salidas_lotes", @lote_control_ganado)

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_ganado_lote

    @lote_control_ganado = LoteSalidaGanado.where("ganado_id = ? ", params[:ganado_id]).first
    aux = @lote_control_ganado 
    
    if @lote_control_ganado.destroy
    
      auditoria_nueva("Eliminar Lote para salida de ganado","tmp_ganados_salidas_lotes", @lote_control_ganado)

    end

    respond_to do |f|

      f.js

    end

  end


  def buscar_ganado

    @ganados = VGanado.where("nombre ilike (?) and estado_ganado_id not in (?) ", "%#{params[:ganado]}%", [PARAMETRO[:estado_ganado_en_proceso_venta], PARAMETRO[:estado_ganado_vendido]])

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


  def seleccionar_lote

    @lote = LoteSalidaGanado.new

    respond_to do |f|

      f.js

    end

  end


  def eliminar_lote

    @lote_eliminado = false
    @valido = true
    @msg = ""

    @lote_salida_ganado = GanadoSalida.where("codigo_lote = ?", params[:codigo_lote])
    
    unless @lote_salida_ganado.present?
      
      @valido = false
      @msg = "No existe el código de lote de salida a Eliminar."

    end
    
    if @valido

      @venta = AuxVenta.where("ganado_salida_lote = ?",params[:codigo_lote])
      @venta.destroy_all

      @lote_salida_ganado_elim = @lote_salida_ganado
      
      GanadoSalida.transaction do

        @lote_salida_ganado.each do |lgs|

            @ganado = Ganado.where("id = ?", lgs.ganado_id).first
            auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida, eliminar lote", "ganados", @ganado)
            @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
            
            if @ganado.save

              auditoria_despues(@ganado, auditoria_id)

            end

        end

        if @lote_salida_ganado.destroy_all

          auditoria_nueva("Eliminar Lote de salida de ganado","ganados_salidas", @lote_salida_ganado_elim)
          @lote_eliminado = true
          
        end

      end

    end

    respond_to do |f|

      f.js

    end


  end


  def cambiar_estado_salida_a_finalizado

    @actualizado = false
    @msg = ""

    Ganado.transaction do

      @ganado_salida = GanadoSalida.where("id = ?", params[:id]).first
      @ganado_salida.estado_movimiento_id = PARAMETRO[:estado_movimiento_finalizado]
      
      if @ganado_salida.save
        
        auditoria_nueva("Finalizar salida de ganado, venta concretada","ganados_salidas", @ganado_salida)
        @ganado = Ganado.where("id = ?", @ganado_salida.ganado_id).first
        auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida", "ganados", @ganado)
        @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_vendido]
        
        if @ganado.save

          auditoria_despues(@ganado, auditoria_id)
          @actualizado = true

        end
        

      end

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

  def seleccionar_lote_a_finalizar

    @lote = LoteSalidaGanado.new

    respond_to do |f|

      f.js

    end

  end


  def finalizar_lote_ganado
  
    @lote_finalizado = false
    @valido = true
    @msg = ""

    Ganado.transaction do

      @ganado_salida = GanadoSalida.where("codigo_lote = ? and estado_movimiento_id <> ?", params[:codigo_lote], PARAMETRO[:estado_movimiento_finalizado])

      unless @ganado_salida.present?

        @valido = false
        @msg = "El lote ingresado no pertenece a un lote a finalizar"

      end

      if @valido

        @ganado_salida.each do |gsl|

          gsl.estado_movimiento_id = PARAMETRO[:estado_movimiento_finalizado]
          
          if gsl.save
            
            auditoria_nueva("Finalizar salida de ganado, venta concretada","ganados_salidas", gsl)
            @ganado = Ganado.where("id = ?", gsl.ganado_id).first
            auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida", "ganados", @ganado)
            @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_vendido]
            
            if @ganado.save

              auditoria_despues(@ganado, auditoria_id)
              @lote_finalizado = true

            end
          
          end

        end

      end

    end

    respond_to do |f|

      f.js

    end

  end


end