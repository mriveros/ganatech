class GanadosController < ApplicationController

  before_filter :require_usuario

  def index
  

  end


  def lista

    cond = []
    args = []
    

    if params[:form_buscar_ganado_id].present?

      cond << "ganado_id = ?"
      args << params[:form_buscar_ganado_id]

    end

    if params[:form_buscar_ganado_codigo_lote].present?

      cond << "codigo_lote = ?"
      args << params[:form_buscar_ganado_codigo_lote]

    end

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


    if params[:form_buscar_ganado_rp_padre].present?

      cond << "rp_padre = ?"
      args << params[:form_buscar_ganado_rp_padre]

    end

    if params[:form_buscar_ganado_rp_madre].present?

      cond << "rp_madre = ?"
      args << params[:form_buscar_ganado_rp_madre]

    end

    if params[:form_buscar_ganado_fecha_nacimiento].present?

      cond << "fecha_nacimiento = ?"
      args << params[:form_buscar_ganado_fecha_nacimiento]

    end

    if params[:form_buscar_ganado_peso_promedio].present?

      cond << "peso_promedio = ?"
      args << params[:form_buscar_ganado_peso_promedio]

    end

    if params[:form_buscar_ganado][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_ganado][:hacienda_id]

    end


    if params[:form_buscar_ganado][:potrero_id].present?

      cond << "potrero_id = ?"
      args << params[:form_buscar_ganado][:potrero_id]

    end

    if params[:form_buscar_ganado][:tipo_ganado_id].present?

      cond << "tipo_ganado_id = ?"
      args << params[:form_buscar_ganado][:tipo_ganado_id]

    end

    if params[:form_buscar_ganado][:raza_ganado_id].present?

      cond << "raza_id = ?"
      args << params[:form_buscar_ganado][:raza_ganado_id]

    end

    if params[:form_buscar_ganado][:etapa_ganado_id].present?

      cond << "etapa_ganado_id = ?"
      args << params[:form_buscar_ganado][:etapa_ganado_id]

    end

    if params[:form_buscar_ganado][:sexo_ganado_id].present?

      cond << "sexo_ganado_id = ?"
      args << params[:form_buscar_ganado][:sexo_ganado_id]

    end

    if params[:form_buscar_ganado][:tipo_concepcion_id].present?

      cond << "tipo_concepcion_id = ?"
      args << params[:form_buscar_ganado][:tipo_concepcion_id]

    end

    if params[:form_buscar_ganado][:estado_ganado_id].present?

      cond << "estado_ganado_id = ?"
      args << params[:form_buscar_ganado][:estado_ganado_id]

    end

    if params[:form_buscar_ganado][:finalidad_ganado_id].present?

      cond << "finalidad_ganado_id = ?"
      args << params[:form_buscar_ganado][:finalidad_ganado_id]

    end

    if params[:form_buscar_ganado_procedencia].present?
      
      if params[:form_buscar_ganado_procedencia] == 'local' || params[:form_buscar_ganado_procedencia] == 'LOCAL' || params[:form_buscar_ganado_procedencia] == 'LOC'|| params[:form_buscar_ganado_procedencia] == 'loc' || params[:form_buscar_ganado_procedencia] == 'loca' || params[:form_buscar_ganado_procedencia] == 'LOCA'
        
        cond << "procedencia isnull"
      
      else
        
        cond << "procedencia ilike ?"
        args << "%#{params[:form_buscar_ganado_procedencia]}%"

      end

    end

    if params[:form_buscar_ganado][:proveedor_ganado_id].present?

      cond << "proveedor_ganado_id = ?"
      args << params[:form_buscar_ganado][:proveedor_ganado_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados =  VGanado.orden_estado.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanado.where(cond).count

    else
     
      @ganados = VGanado.orden_estado.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanado.count

    end

    @total_registros = VGanado.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @ganado = Ganado.new

    ultima_produccion = Ganado.order("created_at").last

    if ultima_produccion.present?

      if ultima_produccion.created_at.year != Time.now.year

        @nuevo_autoincremento = "RP-0" + 1.to_s

      else

         @nuevo_autoincremento = "RP-0" + (ultima_produccion.id + 1).to_s 

      end 

    else
      
      @nuevo_autoincremento = 1

    end

    @codigo_lote = ultima_produccion.codigo_lote + 1

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    raza = Raza.where("id = ?", params[:raza_ganado][:id]).first

    if @valido
      
      @ganado = Ganado.new()
      @ganado.fecha_nacimiento = params[:fecha_nacimiento]
      
      if params[:nombre].present?
        
        @ganado.nombre = params[:nombre]

      else

        @ganado.nombre = params[:rp]

      end

      @ganado.rp = params[:rp]

      if params[:rp_padre_rp].present?
        
        @ganado.rp_padre = params[:rp_padre_rp]
      
      else

        @ganado.rp_padre = "No Especificado"

      end

      if params[:rp_madre_rp].present?
        
        @ganado.rp_madre = params[:rp_madre_rp]
      
      else

        @ganado.rp_madre = "No Especificado"

      end
      
      @ganado.codigo_rfid = params[:codigo_rfid]
      @ganado.potrero_id = params[:potrero][:id]
      if params[:peso_promedio].present?

        @ganado.peso_promedio = params[:peso_promedio]

      else

        @ganado.peso_promedio = 0
        
      end
      @ganado.sexo_ganado_id = params[:sexo_ganado][:id]
      @ganado.tipo_ganado_id = raza.tipo_ganado_id
      @ganado.etapa_ganado_id = params[:etapa_ganado][:id]
      @ganado.raza_id = params[:raza_ganado][:id]
      @ganado.tipo_concepcion_id = params[:tipo_concepcion][:id]
      @ganado.estado_ganado_id = params[:estado_ganado][:id]
      @ganado.observacion = params[:observacion]
      @ganado.codigo_lote = params[:codigo_lote]
      @ganado.finalidad_ganado_id = params[:finalidad_ganado][:id]

        if @ganado.save

          auditoria_nueva("registrar ganado", "ganados", @ganado)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  

      if exc.present?        
        
        @excep = exc.message.split(':')    
        @msg = @excep
        
      end                
              
    respond_to do |f|
      
        f.js
      
    end

  end

  def editar
    
    @ganado = Ganado.find(params[:id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

    valido = true
    @msg = ""

    @ganado = Ganado.find(params[:ganado_id])
    auditoria_id = auditoria_antes("actualizar ganado", "ganados", @ganado)
    raza = Raza.where("id = ?", params[:ganado][:raza_id]).first

    if valido
      
      @ganado.fecha_nacimiento = params[:ganado][:fecha_nacimiento]
      @ganado.nombre = params[:ganado][:nombre]
      @ganado.rp = params[:ganado][:rp]

      if params[:rp_padre_rp].present?
        
        @ganado.rp_padre = params[:rp_padre_rp]
      
      else

        @ganado.rp_padre = "No Especificado"

      end

      if params[:rp_madre_rp].present?
        
        @ganado.rp_madre = params[:rp_madre_rp]
      
      else

        @ganado.rp_madre = "No Especificado"

      end
      
      @ganado.codigo_rfid = params[:ganado][:codigo_rfid]
      @ganado.potrero_id = params[:potrero][:id]
      @ganado.peso_promedio = params[:ganado][:peso_promedio]
      @ganado.sexo_ganado_id = params[:sexo_ganado][:id]
      @ganado.tipo_ganado_id = raza.tipo_ganado_id
      @ganado.etapa_ganado_id = params[:etapa_ganado][:id]
      @ganado.raza_id = params[:ganado][:raza_id]
      @ganado.tipo_concepcion_id = params[:ganado][:tipo_concepcion_id]
      @ganado.estado_ganado_id = params[:ganado][:estado_ganado_id]
      @ganado.observacion = params[:ganado][:observacion]
      @ganado.codigo_lote = params[:ganado][:codigo_lote]
      @ganado.finalidad_ganado_id = params[:ganado][:finalidad_ganado_id]
      
      if @ganado.save

        @ganado_ok = true
        auditoria_despues(@ganado, auditoria_id)

      end
    
    end
    
    rescue Exception => exc  
      
      if exc.present?        
        
        @excep = exc.message.split(':')    
        @msg = @excep
      
      end                
        
    respond_to do |f|

      f.js

    end

  end

  def eliminar

    @valido = true
    @msg = ""

    @ganado = Ganado.find(params[:id])

    @ganado_elim = @ganado  

    if @valido

      if @ganado.destroy

        auditoria_nueva("eliminar ganado", "ganados", @ganado_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el Ganado."

      end

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
        @eliminado = false
        
      end
        
    respond_to do |f|

      f.js

    end

  end


  def obtener_etapa_ganado

    @etapas_ganados = EtapaGanado.where("sexo_ganado_id = ?", params[:sexo_ganado_id])
    
    respond_to do |f|
      
      f.json { render :json => @etapas_ganados }
    
    end

  end


  def buscar_rp_padre
    
    @ganados = Ganado.where("nombre ilike ? and sexo_ganado_id = ?", "%#{params[:rp_pad]}%", PARAMETRO[:sexo_ganado_macho])

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end
    
  end


  def buscar_rp_madre
    
    @ganados =  Ganado.where("nombre ilike ? and sexo_ganado_id = ?", "%#{params[:rp_mad]}%", PARAMETRO[:sexo_ganado_hembra])

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end
    
  end


  def ganado_detalle

    @ganado_detalle = Ganado.where("id =?", params[:ganado_id]).first

    @control_sanitario = VControlGanado.orden_fecha.where("ganado_id =?", params[:ganado_id]).paginate(per_page: 5, page: params[:page])

    @control_alimentacion = VControlAlimentacion.orden_fecha.where("ganado_id = ?", params[:ganado_id]).paginate(per_page: 5, page: params[:page])
    
    @data_set_line_chart =  ControlGanado.where("ganado_id = ? and peso IS NOT NULL", params[:ganado_id]).order("fecha_control")
    
    if @data_set_line_chart.present?
      
      
      @peso_maximo = @data_set_line_chart.maximum("peso")
      @peso_minimo = @data_set_line_chart.minimum("peso")
      @peso_medio = @data_set_line_chart.average(:peso)

    end
    
    @data_set_pie_chart_med = VControlGanado.where("ganado_id = ? and control_id <> ?", params[:ganado_id], PARAMETRO[:control_peso])
    @data_set_pie_chart_food = VControlAlimentacion.where("ganado_id = ?", params[:ganado_id])

    respond_to do |f|

      f.js

    end

  end

  def agregar_control_sanitario

    @fecha = Date.today
    
    @control_ganado = ControlGanado.new

   respond_to do |f|

      f.js

    end
  
  end


   def guardar_control_sanitario
    
    @valido = true
    @msg = ""
    @guardado_ok = false
    control_ganado = ControlGanado.order("created_at").last
    codigo_control = control_ganado.id + 1

    if params[:control][:id].to_i != PARAMETRO[:control_peso] &&  params[:control][:id].to_i != PARAMETRO[:control_palpacion] &&  params[:control][:id].to_i != PARAMETRO[:control_castracion]

      medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first
      
      if medicamento.cantidad_stock < params[:cantidad_suministrada].to_i

        @valido = false
        @msg += "No hay suficiente stock del Medicamento."

      end

    end
   

    if @valido
      
      @control_ganado = ControlGanado.new()
      @control_ganado.fecha_control = params[:fecha_control]
      @control_ganado.ganado_id = params[:ganado_id]
      @control_ganado.control_id = params[:control][:id]

      if params[:control][:id].to_i == PARAMETRO[:control_peso]

        @control_ganado.peso = params[:peso_promedio_control]
      
      else

        @control_ganado.peso = params[:peso_promedio]
        @control_ganado.medicamento_id = params[:medicamento_id]
        @control_ganado.cantidad_suministrada = params[:cantidad_suministrada]

      end

      @control_ganado.observacion = params[:observacion]
      @control_ganado.codigo = codigo_control
      @control_ganado.clasificacion_control_id = PARAMETRO[:clasificacion_por_ganado]

        if @control_ganado.save

          @guardado_ok = true
          #ACTUALIZAR PESO DEL GANADO
          @ganado = Ganado.where("id = ?", params[:ganado_id]).first
          if params[:peso_promedio_control].present?
            
            @ganado.peso_promedio = params[:peso_promedio_control]

          end

          if params[:peso_promedio].present?
            
            @ganado.peso_promedio = params[:peso_promedio]
            
          end

          @ganado.save

          auditoria_nueva("agregar control sanitario de ganado", "controles_ganados", @control_ganado)
          
          if params[:control][:id].to_i == PARAMETRO[:control_castracion].to_i

            if @ganado.etapa_ganado_id == PARAMETRO[:etapa_ganado_torito] || @ganado.etapa_ganado_id == PARAMETRO[:etapa_ganado_toro]

              @ganado.etapa_ganado_id = PARAMETRO[:etapa_ganado_novillo]
              @ganado.save

            end

          end
          
        end 

        #HISTORIAL GANADO
        historial_ganado = HistorialGanado.new
        historial_ganado.ganado_id = params[:ganado_id]
        historial_ganado.modulo = "CONTROLES GANADOS"
        historial_ganado.accion = "Sanitaciones"
        historial_ganado.fecha = params[:fecha_control]
        historial_ganado.control_ganado_id = @control_ganado.id
        historial_ganado.peso = @control_ganado.peso
        historial_ganado.observacion = params[:observacion]
        historial_ganado.save

    end
  
    rescue Exception => exc  
    
      if exc.present?

        @excep = exc.message.split(':')    
        @msg = @excep
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def eliminar_control_sanitario

    @valido = true
    @msg = ""

    @control_sanitario = ControlGanado.where("id = ?", params[:control_ganado_id]).first

    @control_sanitario_elim = @control_sanitario  

    if @valido

      if @control_sanitario.destroy

        auditoria_nueva("eliminar control sanitario", "controles_ganados", @control_sanitario_elim)

        @eliminado = true

      end

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
        @eliminado = false
        
      end
        
    respond_to do |f|

      f.js

    end

  end

  def agregar_control_alimentacion

    @fecha = Date.today
    
    @control_alimentacion = ControlAlimentacion.new

   respond_to do |f|

      f.js

    end
  
  end


   def guardar_control_alimentacion
    
    @valido = true
    @msg = ""
    @guardado_ok = false
    codigo_lote = ControlAlimentacion.last

    alimentacion = Alimentacion.where("id = ?", params[:alimentacion_id]).first
      
    if alimentacion.cantidad_stock < params[:cantidad_suministrada].to_i

      @valido = false
      @msg = "No hay suficiente stock del Alimento"

    end
  

    if @valido
      
      @control_alimentacion = ControlAlimentacion.new()
      @control_alimentacion.fecha_control = params[:fecha_control]
      @control_alimentacion.ganado_id = params[:ganado_id]
      @control_alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
      @control_alimentacion.alimentacion_id = params[:alimentacion_id]
      @control_alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
      @control_alimentacion.observacion = params[:observacion]
      @control_alimentacion.codigo_lote = codigo_lote.codigo_lote + 1
      @control_alimentacion.clasificacion_alimentacion_id = PARAMETRO[:clasificacion_alimentacion_por_ganado]

        if @control_alimentacion.save

          auditoria_nueva("agregar control de alimentacion al ganado", "controles_alimentaciones", @control_alimentacion)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    
      if exc.present?

        @excep = exc.message.split(':')    
        @msg = @excep
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def eliminar_control_alimentacion

    @valido = true
    @msg = ""

    @control_alimentacion = ControlAlimentacion.where("id = ?", params[:control_alimentacion_id]).first

    @control_alimentacion_elim = @control_alimentacion  

    if @valido

      if @control_alimentacion.destroy

        auditoria_nueva("eliminar control de alimentacion de ganado", "controles_alimentaciones", @control_alimentacion_elim)

        @eliminado = true

      end

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
        @eliminado = false
        
      end
        
    respond_to do |f|

      f.js

    end

  end

  def adjuntar_archivo

    @control_ganado = ControlGanado.where("id = ?", params[:control_ganado_id]).first



    respond_to do |f|

      f.js

    end

  end

  def guardar_archivo_adjunto

    @valido = true
    @msg = ""

    @control_ganado = ControlGanado.where("id = ?", params[:control_ganado_id]).first

    if @valido

      DocumentoGanatec.transaction do 

        @documento_ganatec = DocumentoGanatec.new
        @documento_ganatec.numero = params[:numero]
        @documento_ganatec.descripcion = params[:descripcion]
        @documento_ganatec.fecha_emision = params[:fecha_emision]
        @documento_ganatec.tipo_resolucion_id = PARAMETRO[:tipo_resolucion_control_ganado]
        @documento_ganatec.data = params[:data]

        if @documento_ganatec.save

          auditoria_nueva("agregar documento nuevo en ganatec", "documentos_ganatec", @documento_ganatec)

          @control_ganado.documento_ganatec_id = @documento_ganatec.id
          
          if  @control_ganado.save

            @valido = true
            auditoria_nueva("agregar documento adjunto al control de ganado", "ganados_controles", @control_ganado)

          end


        end

      end #end transaction

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
        @eliminado = false
        
      end

    
    respond_to do |f|

      f.js

    end

  end

  def agregar_celo

    @ganado = Ganado.where("id = ?", params[:ganado_id]).first

    respond_to do |f|

      f.js

    end

  end

  def guardar_celo

    @valido = true
    @guardado_ok = false
    @msg = ""

    @ganado = Ganado.where("id = ?", params[:ganado_id]).first
    auditoria_id = auditoria_antes("cambiar estado de ganado en celo", "ganados", @ganado)

    Ganado.transaction do

      if @valido 

        @celo = Celo.new
        @celo.ganado_id = params[:ganado_id]
        @celo.descripcion = params[:descripcion]
        @celo.observacion = params[:observacion]
        @celo.fecha_inicio = params[:fecha_inicio]
        @celo.fecha_fin = params[:fecha_fin]
        @celo.estado_celo_id = PARAMETRO[:estado_celo_en_celo_activo]

        if @celo.save

          auditoria_nueva("agregar nuevo celo", "celos", @celo)
          #cambiamos el estado del ganado a En Celo
          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_en_celo]
          
          if @ganado.save

            @guardado_ok = true
            auditoria_despues(@ganado, auditoria_id)

          end

        end

      end

    end #end transaction

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep.to_s
        
      end

    respond_to do |f|

      f.js

    end

  end


  def buscar_ganado

    if params[:ganado_id].present?

      @ganados = VGanado.where("ganado_id = ?", params[:ganado_id])
    
    else

      @ganados = VGanado.where("nombre ilike ? and sexo_ganado_id = ? and estado_ganado_id = ?", "%#{params[:ganado]}%", params[:sexo_ganado_id], PARAMETRO[:estado_ganado_activo])
    
    end
    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


  def agregar_lote_ganado

    @ganado = Ganado.new

    ultima_produccion = Ganado.order("created_at").last

    if ultima_produccion.present?

      if ultima_produccion.created_at.year != Time.now.year

        @nuevo_autoincremento = "RP-0" + 1.to_s

      else

         @nuevo_autoincremento = "RP-0" + (ultima_produccion.id + 1).to_s 

      end 

    else
      
      @nuevo_autoincremento = 1

    end

    @codigo_lote = ultima_produccion.codigo_lote + 1

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar_lote_ganado

    @valido = true
    @msg = ""
    @guardado_ok = false
    contador = 0

    raza = Raza.where("id = ?", params[:raza_ganado][:id]).first

    if @valido
      
      while params[:cantidad_lote].to_i > contador.to_i do
        
        @ganado = Ganado.new()
        
        ultima_produccion = Ganado.order("created_at").last
        nuevo_rp = "RP-0" + (ultima_produccion.id + 1).to_s 
        @ganado.nombre = nuevo_rp
        @ganado.rp = nuevo_rp
        @ganado.rp_padre = "No Especificado"
        @ganado.rp_madre = "No Especificado"
        if params[:codigo_rfid].present?

          @ganado.codigo_rfid = params[:codigo_rfid]

        else

          @ganado.codigo_rfid = ""

        end
        @ganado.potrero_id = params[:potrero][:id]
        @ganado.peso_promedio = params[:peso_promedio]
        @ganado.sexo_ganado_id = params[:sexo_ganado][:id]
        @ganado.tipo_ganado_id = raza.tipo_ganado_id
        @ganado.etapa_ganado_id = params[:etapa_ganado][:id]
        @ganado.raza_id = params[:raza_ganado][:id]
        @ganado.tipo_concepcion_id = params[:tipo_concepcion][:id]
        @ganado.estado_ganado_id = params[:estado_ganado][:id]
        @ganado.observacion = params[:observacion]
        @ganado.codigo_lote = params[:codigo_lote]
        @ganado.finalidad_ganado_id = params[:finalidad_ganado][:id]
        
        if @ganado.save

          auditoria_nueva("registrar ganado por lote", "ganados", @ganado)
          @guardado_ok = true
          contador = contador + 1
         
        end 

      end

    end
  
    rescue Exception => exc  

      if exc.present?        
        
        @excep = exc.message.split(':')    
        @msg = @excep
        
      end                
              
    respond_to do |f|
      
        f.js
      
    end

  end



  def marcar_con_enfermedad

    @fecha = Date.today
    
    @ganado_enfermedad = GanadoEnfermo.new

   respond_to do |f|

      f.js

    end
  
  end

  def guardar_ganado_enfermedad
    
    @guardado_ok = false
    @msg = ""
    @valido = true

    GanadoEnfermo.transaction do 

      
      if @valido

        @ganado = Ganado.where("id = ?", params[:ganado_id]).first
        auditoria_id = auditoria_antes("guardar ganado con enfermedad", "ganados", @ganado)

        @ganado_enfermedad = GanadoEnfermo.new
        @ganado_enfermedad.fecha = params[:fecha]
        @ganado_enfermedad.ganado_id = params[:ganado_id]
        @ganado_enfermedad.enfermedad_id = params[:enfermedad][:id]
        @ganado_enfermedad.observacion = params[:observacion]
        @ganado_enfermedad.estado_enfermedad_id = params[:estado_enfermedad][:id]
        @ganado_enfermedad.estado_corporal_id = params[:estado_corporal][:id]

        
        if @ganado_enfermedad.save

          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_enfermo]
          
          if @ganado.save
            
            @guardado_ok = true
            auditoria_despues(@ganado, auditoria_id)
            

          end

        end

      end

    end #end transaction 
    estado_enfermedad = EstadoEnfermedad.where('id = ?', params[:estado_enfermedad][:id]).first
    enfermedad = Enfermedad.where('id = ?', params[:enfermedad][:id]).first
    modulo = 'Módulo Ganados Enfermos'
    subject = 'Ganado Marcado como Enfermo'
    adjunto =  'Ganado Nombre: ' + @ganado.nombre + ' Enfermedad: ' + enfermedad.descripcion.to_s + ' Estado: ' + estado_enfermedad.descripcion.to_s
    NotificarUsuario.test_email(current_usuario.id,subject ,adjunto,modulo).deliver

    respond_to do |f|

      f.js

    end
  
  end


  def marcar_como_muerto

    @fecha = Date.today
    
    @ganado_muerto = GanadoMuerto.new
    @ganado_muerto_codigo = GanadoMuerto.last
    if @ganado_muerto_codigo.present?

      @ganado_muerto_codigo = @ganado_muerto_codigo.id.to_i + 1

    else

      @ganado_muerto_codigo = 1
      
    end

   respond_to do |f|

      f.js

    end
  
  end

  def guardar_ganado_muerto
    
    @guardado_ok = false
    @msg = ""
    @valido = true

    GanadoMuerto.transaction do 

      if @valido

        @ganado = Ganado.where("id = ?", params[:ganado_id]).first

        auditoria_id = auditoria_antes("guardar ganado muerto", "ganados", @ganado)

        @ganado_muerto = GanadoMuerto.new
        @ganado_muerto.fecha = params[:fecha]
        @ganado_muerto.ganado_id = params[:ganado_id]
        @ganado_muerto.motivo_muerte_id = params[:motivo_muerte][:id]
        @ganado_muerto.observacion = params[:observacion]
        
        if @ganado_muerto.save

          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_muerto]
          
          if @ganado.save
            
            
            auditoria_despues(@ganado, auditoria_id)
            
            @documento_ganatec = DocumentoGanatec.new
            @documento_ganatec.numero = params[:numero]
            @documento_ganatec.descripcion = params[:descripcion]
            @documento_ganatec.fecha_emision = params[:fecha]
            @documento_ganatec.tipo_resolucion_id = PARAMETRO[:tipo_resolucion_ganado_muerto]
            @documento_ganatec.data = params[:data]

            if @documento_ganatec.save
              
              @guardado_ok = true
              @ganado_muerto.documento_ganatec_id = @documento_ganatec.id
              @ganado_muerto.save
              motivo_muerte = MotivoMuerte.where('id = ?', params[:motivo_muerte][:id]).first
              subject = 'Ganado marcado como muerto'
              modulo = 'Ganados'
              adjunto = 'Nombre Ganado: ' + @ganado.nombre  + ' Motivo: ' + motivo_muerte.descripcion.to_s
              NotificarUsuario.test_email(current_usuario.id,subject ,adjunto,modulo).deliver
              
            end

          end

        end

      end

    end #end transaction 
    
    respond_to do |f|

      f.js

    end
  
  end

  def marcar_como_produccion

    @guardado_ok = false
    @valido = true

    @ganado = Ganado.where("id = ?", params[:ganado_id]).first

    ganado_alta_produccion = AltaProduccion.where("ganado_id = ? and periodo = ? and estado_alta_produccion_id = ?", params[:ganado_id], Time.now.year.to_s, PARAMETRO[:estado_alta_produccion_activa]).first

    if ganado_alta_produccion.present?

      @valido = false
      @msg = "El Ganado ya se encuentra en el modulo de Alta Producción"

    end


    if @valido

      ganado_alta_produccion = AltaProduccion.new
      ganado_alta_produccion.ganado_id = params[:ganado_id]
      ganado_alta_produccion.periodo = Time.now.month.to_s+'-'+Time.now.year.to_s
      ganado_alta_produccion.estado_alta_produccion_id = PARAMETRO[:estado_alta_produccion_activa]
      
      if ganado_alta_produccion.save

        @guardado_ok = true

      end

    end


    respond_to do |f|

      f.js

    end

  end



end
