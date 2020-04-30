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

    if params[:form_buscar_ganado_codigo_rfid].present?

      cond << "codigo_rfid = ?"
      args << params[:form_buscar_ganado_codigo_rfid]

    end

    if params[:form_buscar_ganado_rp].present?

      cond << "rp = ?"
      args << params[:form_buscar_ganado_rp]

    end

    if params[:form_buscar_ganado_rp_padre].present?

      cond << "rp_padre = ?"
      args << "%#{params[:form_buscar_ganado_rp_padre]}%"

    end

    if params[:form_buscar_ganado_rp_madre].present?

      cond << "rp_madre = ?"
      args << "%#{params[:form_buscar_ganado_rp_madre]}%"

    end

    if params[:form_buscar_ganado_fecha_nacimiento].present?

      cond << "fecha_nacimiento = ?"
      args << params[:form_buscar_ganado_fecha_nacimiento]

    end

    if params[:form_buscar_ganado_potrero_id].present?

      cond << "potrero_id = ?"
      args << params[:form_buscar_ganado_potrero_id]

    end

    if params[:form_buscar_ganado_raza_id].present?

      cond << "raza_id = ?"
      args << params[:form_buscar_ganado_raza_id]

    end

    if params[:form_buscar_ganado_tipo_concepcion_id].present?

      cond << "tipo_concepcion_id = ?"
      args << params[:form_buscar_ganado_tipo_concepcion_id]

    end

    if params[:form_buscar_ganado_estado_ganado_id].present?

      cond << "estado_ganado_id = ?"
      args << params[:form_buscar_ganado_estado_ganado_id]

    end

    if params[:form_buscar_ganado_clase_ganado_id].present?

      cond << "clase_ganado_id = ?"
      args << params[:form_buscar_ganado_clase_ganado_id]

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

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:persona_documento].present?

      @valido = false
      @msg += " Debe Completar el campo Documento. \n"

    end

    if @valido
      
      @ganado = Ganado.new()
      @ganado.raza_id = params[:raza_id]

        if @ganado.save

          auditoria_nueva("registrar ganado", "ganados", @ganado)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
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

    if valido

      @ganado.raza_id = params[:raza_id]
      auditoria_despues(@ganado, auditoria_id)

      if @ganado.save

        @ganado_ok = true

      end
    
    end
    
    rescue Exception => exc  
      # dispone el mensaje de error 
      #puts "Aqui si muestra el error ".concat(exc.message)
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
      # dispone el mensaje de error 
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
        @eliminado = false
        
      end
        
    respond_to do |f|

      f.js

    end

  end

  def ganado_detalle

    @ganado = Ganado.find(params[:ganado_id])

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


end