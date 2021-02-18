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
      @parametros = { format: :pdf, codigo_lote: params[:form_buscar_control_ganado_codigo] }

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
    @codigo_control = nuevo_incremento.codigo + 1

    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = " "
    @guardado_ok = false

    if params[:control][:id].to_i != PARAMETRO[:control_palpacion]

      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        
        medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

        if medicamento.cantidad_stock < params[:cantidad_suministrada].to_i

          @msg = "No hay suficiente Stock para aplicar este medicamento. "
          @valido = false

        end

      end

      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_potrero]
        
        @ganado_potrero = VGanado.modulo_control_ganado.where("potrero_id = ?", params[:potrero][:id])
        medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

        if medicamento.cantidad_stock < (params[:cantidad_suministrada].to_i * @ganado_potrero.size.to_i)

          @msg = "No hay suficiente Stock para aplicar este medicamento. "
          @valido = false

        end

      end

      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_hacienda]
        
        @ganado_hacienda =VGanado.modulo_control_ganado.where("hacienda_id = ?", params[:hacienda_select][:id])
        medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

        if medicamento.cantidad_stock < (params[:cantidad_suministrada].to_i * @ganado_hacienda.size.to_i)

          @msg = "No hay suficiente Stock para aplicar este medicamento. "
          @valido = false

        end

      end


      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_lote]
        
        @ganado_lote =LoteControlGanado.all
        medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first

        if medicamento.cantidad_stock < (params[:cantidad_suministrada].to_i * @ganado_lote.size.to_i)

          @msg = "No hay suficiente Stock para aplicar este medicamento. "
          @valido = false

        end

      end

    end


    
    if @valido

      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        
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

          @ganado = Ganado.where('id = ?',params[:ganado_id]).first
          if params[:control][:id].to_i == PARAMETRO[:control_castracion].to_i

            if @ganado.etapa_ganado_id == PARAMETRO[:etapa_ganado_torito] || @ganado.etapa_ganado_id == PARAMETRO[:etapa_ganado_toro]

              @ganado.etapa_ganado_id = PARAMETRO[:etapa_ganado_novillo]
              @ganado.save

            end

          end

          @guardado_ok = true

        end

      end

      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_potrero]
        
        @ganado_potrero.each do |ganado|

          @control_ganado = ControlGanado.new
          @control_ganado.ganado_id = ganado.id
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


      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_hacienda]
        
        @ganado_hacienda.each do |ganado|

          @control_ganado = ControlGanado.new
          @control_ganado.ganado_id = ganado.id
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


      if params[:clasificacion_control][:id].to_i == PARAMETRO[:clasificacion_por_lote]
        
        @ganado_lote.each do |ganado|

          @control_ganado = ControlGanado.new
          @control_ganado.ganado_id = ganado.ganado_id
          @control_ganado.fecha_control = params[:fecha_control]
          @control_ganado.control_id = params[:control][:id]
          @control_ganado.medicamento_id = params[:medicamento_id]
          @control_ganado.cantidad_suministrada = params[:cantidad_suministrada]
          @control_ganado.codigo = params[:codigo_lote]
          @control_ganado.clasificacion_control_id = params[:clasificacion_control][:id]
          @control_ganado.observacion = params[:observacion]

          if @control_ganado.save

            @ganado = Ganado.where('id = ?',ganado.ganado_id).first
            if params[:control][:id].to_i == PARAMETRO[:control_castracion].to_i

              if @ganado.etapa_ganado_id == PARAMETRO[:etapa_ganado_torito] || @ganado.etapa_ganado_id == PARAMETRO[:etapa_ganado_toro]

                @ganado.etapa_ganado_id = PARAMETRO[:etapa_ganado_novillo]
                @ganado.save

              end

            end

            @guardado_ok = true

          end

        end
        #Borrar toda la tabla
        LoteControlGanado.destroy_all

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

      @ganados =  VGanado.modulo_control_ganado.orden_01.where(cond).paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.modulo_control_ganado.where(cond).count

    else
     
      @ganados = VGanado.modulo_control_ganado.orden_01.paginate(per_page: 5, page: params[:page])
      @total_encontrados = VGanado.modulo_control_ganado.count

    end

    @total_registros = VGanado.modulo_control_ganado.count


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

    @ganados = VGanado.modulo_control_ganado.where("nombre ilike (?) ", "%#{params[:ganado]}%")

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

  def obtener_resumen_control_ganado

    @lote_ganado = params[:parametros]

    respond_to do |f|

      f.js

    end

  end

  def imprimir_resumen_control_ganado

    
    @lote_ganado =  VControlGanado.where("codigo = ?", params[:codigo_lote]).orden_01.paginate(per_page: 10, page: params[:page])

    respond_to do |f|
      
      f.pdf do

          render  :pdf => "planilla_resumen_control_ganado_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'controles_ganados/planilla_resumen_control_ganado.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "controles_ganados/cabecera_planilla_resumen_control_ganado.pdf.erb" ,
                  :locals   => { :venta => @lote_ganado }}},
                  :margin => {:top => 65,
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Landscape',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }

      end
      
    end

  end

end