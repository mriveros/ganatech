class GanadosFaenasController < ApplicationController
 
before_filter :require_usuario

  def index
  
 
  end 
  
  def lista

    cond = []
    args = []

    if params[:form_buscar_ganado_faena_id].present? 

      cond << "id = ?"
      args << params[:form_buscar_ganado_faena_id]

    end

    if params[:form_buscar_ganado_faena_fecha].present?

      cond << "fecha_salida = ?"
      args << params[:form_buscar_ganado_faena_fecha_salida]

    end

    if params[:form_buscar_ganado_faena_descripcion].present?

      cond << "descripcion ilike = ?"
      args << "%#{params[:form_buscar_ganado_faena_descripcion]}%"

    end  

    if params[:form_buscar_ganado_faena][:motivo_faena_id].present?

      cond << "motivo_faena_id = ?"
      args << params[:form_buscar_ganado_faena][:motivo_faena_id]

    end

    if params[:form_buscar_ganado_faena_cantidad].present?

      cond << "cantidad = ?"
      args << params[:form_buscar_ganado_faena_cantidad]

    end 

    if params[:form_buscar_ganado_faena_monto_total].present?

      cond << "monto_total = ?"
      args << params[:form_buscar_ganado_faena_monto_total]

    end  
    
    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_faenas =  GanadoFaena.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = GanadoFaena.where(cond).count

    else
     
      @ganados_faenas = GanadoFaena.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = GanadoFaena.count

    end

    @total_registros = GanadoFaena.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @ganado_faena = GanadoFaena.new
    

    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    if @valido
      
      GanadoFaena.transaction do

        if params[:clasificacion_salida][:id].to_i == PARAMETRO[:clasificacion_salida_por_ganado]
          
          @ganado_faena = GanadoSalida.new
          @ganado_faena.peso_promedio = params[:peso_promedio]
          @ganado_faena.ganado_id = params[:ganado_id]
          @ganado_faena.tipo_salida_id = params[:tipo_salida][:id]
          @ganado_faena.precio_venta = params[:precio_venta].to_s.gsub(/[$.]/,'').to_i
          @ganado_faena.observacion = params[:observacion]
          @ganado_faena.estado_movimiento_id = PARAMETRO[:estado_movimiento_en_proceso]
          @ganado_faena.cliente_id = params[:cliente_id]
          @ganado_faena.codigo_lote = params[:codigo_lote]
          @ganado_faena.clasificacion_salida_id = params[:clasificacion_salida][:id]
          @ganado_faena.fecha_salida = params[:fecha_salida]

          if @ganado_faena.save

            auditoria_nueva("Guardar salida de Ganado","ganados_salidas", @ganado_faena)
            @ganado = Ganado.where("id = ?", params[:ganado_id]).first
            auditoria_id = auditoria_antes("actualizar estado de ganado en modulo de salida", "ganados", @ganado)
            @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_faena]
              
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

            @ganado_faena = GanadoSalida.new
            @ganado_faena.peso_promedio = params[:peso_promedio]
            @ganado_faena.ganado_id =  ganado.ganado_id
            @ganado_faena.tipo_salida_id = params[:tipo_salida][:id]
            @ganado_faena.precio_venta = params[:precio_venta].to_s.gsub(/[$.]/,'').to_i
            @ganado_faena.observacion = params[:observacion]
            @ganado_faena.estado_movimiento_id = PARAMETRO[:estado_movimiento_en_proceso]
            @ganado_faena.cliente_id = params[:cliente_id]
            @ganado_faena.codigo_lote = params[:codigo_lote]
            @ganado_faena.clasificacion_salida_id = params[:clasificacion_salida][:id]
            @ganado_faena.fecha_salida = params[:fecha_salida]

            if @ganado_faena.save

              auditoria_nueva("Guardar salida de Ganado","ganados_salidas", @ganado_faena)

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
          @venta.descripcion = "FAENA DE GANADOS: Venta de Ganado CODIGO: #{params[:codigo_lote]} "
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

 
 def eliminar_ganado_faena

    @eliminado = false
    @msg = ""

    Ganado.transaction do

      @ganado_faena = GanadoFaena.where("id = ?", params[:id]).first
      @ganado_faena_elim = @ganado_faena
      
      @venta = AuxVenta.where("ganado_salida_lote = ?", @ganado_faena.codigo_lote).first
      @venta.monto = @venta.monto - @ganado_faena.precio_venta
      @venta.save

      if @ganado_faena.destroy
        
        auditoria_nueva("Eliminar salida de Ganado","ganados_salidas", @ganado_faena_elim)
        @ganado = Ganado.where("id = ?", @ganado_faena_elim.ganado_id).first
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

    @lote_ganado_faena = LoteGanadoFaena.new
    @lote_ganado_faena.ganado_id = params[:ganado_id]
    
    if @lote_ganado_faena.save

      auditoria_nueva("Guardar Lote para para salida de ganado","tmp_ganados_faenas_lotes", @lote_ganado_faena)

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_ganado_lote

    @lote_ganado_faena = LoteGanadoFaena.where("ganado_id = ? ", params[:ganado_id]).first

    aux = @lote_ganado_faena 
    
    if @lote_ganado_faena.destroy
    
      auditoria_nueva("Eliminar Lote para faena de ganado","tmp_ganados_faenas_lotes", @lote_ganado_faena)

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

    @lote = LoteGanadoFaena.new

    respond_to do |f|

      f.js

    end

  end


  def eliminar_lote

    @lote_eliminado = false
    @valido = true
    @msg = ""

    @lote_salida_ganado = GanadoFaena.where("codigo_lote = ?", params[:codigo_lote])
    
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


  def buscar_cliente
    
    @cliente = Cliente.where("nombre_razon_social ilike ?", "%#{params[:cliente]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @cliente }
    
    end
    
  end

end