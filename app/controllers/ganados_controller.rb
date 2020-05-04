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

  def agregar

    @ganado = Ganado.new

    ultima_produccion = Ganado.order("created_at").last

    if ultima_produccion.present?

      if ultima_produccion.created_at.month != Time.now.month

        @nuevo_autoincremento = "RP-0" + 1.to_s

      else

         @nuevo_autoincremento = "RP-0" + (ultima_produccion.id + 1).to_s 

      end 

    else
      
      @nuevo_autoincremento = 1

    end

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
      @ganado.nombre = params[:nombre]
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
      @ganado.peso_promedio = params[:peso_promedio]
      @ganado.sexo_ganado_id = params[:sexo_ganado][:id]
      @ganado.tipo_ganado_id = raza.tipo_ganado_id
      @ganado.etapa_ganado_id = params[:etapa_ganado][:id]
      @ganado.raza_id = params[:raza_ganado][:id]
      @ganado.tipo_concepcion_id = params[:tipo_concepcion][:id]
      @ganado.estado_ganado_id = params[:estado_ganado][:id]
      @ganado.observacion = params[:observacion]
      


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

    @control_sanitario = VControlGanado.where("ganado_id =?", params[:ganado_id]).paginate(per_page: 10, page: params[:page])

    @control_alimentacion = VControlAlimentacion.where("ganado_id = ?", params[:ganado_id]).paginate(per_page: 10, page: params[:page])

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

    if params[:control][:id].to_i != PARAMETRO[:control_peso]

      medicamento = Medicamento.where("id = ?", params[:medicamento_id]).first
      
      if medicamento.cantidad_stock < params[:cantidad_suministrada].to_i

        @valido = false
        @msg = "No hay suficiente stock del Medicamento"

      end

    end
   

    if @valido
      
      @control_ganado = ControlGanado.new()
      @control_ganado.fecha_control = params[:fecha_control]
      @control_ganado.ganado_id = params[:ganado_id]
      @control_ganado.control_id = params[:control][:id]

      if params[:control_id] == PARAMETRO[:control_peso]

        @control_ganado.peso = params[:peso_promedio_control]
      
      else

        @control_ganado.peso = params[:peso_promedio]
        @control_ganado.medicamento_id = params[:medicamento_id]
        @control_ganado.cantidad_suministrada = params[:cantidad_suministrada]

      end

      @control_ganado.observacion = params[:observacion]

        if @control_ganado.save

          auditoria_nueva("agregar control sanitario de ganado", "controles_ganados", @control_ganado)
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
   
    alimentacion = Alimentacion.where("id = ?", params[:alimento_id]).first
      
    if alimentacion.cantidad_stock < params[:cantidad_suministrada].to_i

      @valido = false
      @msg = "No hay suficiente stock del Alimento"

    end
  

    if @valido
      
      @control_alimentacion = ControlAlimentacion.new()
      @control_alimentacion.fecha_control = params[:fecha_control]
      @control_alimentacion.ganado_id = params[:ganado_id]
      @control_alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
      @control_alimentacion.alimentacion_id = params[:alimentacion][:id]
      @control_alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
      @control_alimentacion.observacion = params[:observacion]

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


end