class CelosController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_celo_id].present?

      cond << "celo_id = ?"
      args << params[:form_buscar_celo_id]

    end

    if params[:form_buscar_celo_ganado_rfid].present?

      cond << "codigo_rfid = ?"
      args << params[:form_buscar_celo_ganado_rfid]

    end

    if params[:form_buscar_celo_ganado_nombre].present?

      cond << "ganado_nombre  ilike ?"
      args << "%#{params[:form_buscar_celo_ganado_nombre]}%"

    end

    if params[:form_buscar_celo_ganado_rp].present?

      cond << "ganado_rp = ?"
      args << params[:form_buscar_celo_ganado_rp]

    end

    if params[:form_buscar_celo_fecha_inicio].present?

      cond << "fecha_inicio = ?"
      args << params[:form_buscar_celo_fecha_inicio]

    end

    if params[:form_buscar_celo_fecha_fin].present?

      cond << "fecha_fin = ?"
      args << params[:form_buscar_celo_fecha_fin]

    end

    if params[:form_buscar_celo_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_celo_descripcion]}%"

    end

    if params[:form_buscar_celo][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_celo][:hacienda_id]

    end

    if params[:form_buscar_celo][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_celo][:hacienda_id]

    end

    if params[:form_buscar_celo][:estado_celo_id].present?

      cond << "estado_celo_id = ?"
      args << params[:form_buscar_celo][:estado_celo_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @celos =  VCelo.orden_estado_celo.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VCelo.where(cond).count

    else
     
      @celos = VCelo.orden_estado_celo.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VCelo.count

    end

    @total_registros = VCelo.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @celo = Celo.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    @ganado = Ganado.where("id = ?", params[:ganado_id]).first
    auditoria_id = auditoria_antes("cambiar estado de ganado en celo", "ganados", @ganado)
    @celo = Celo.where("ganado_id = ? and estado_celo_id = ?", params[:ganado_id], PARAMETRO[:estado_celo_en_celo_activo]).first
    if @celo.present?

      @msg = " El ganado ya se encuentra actualmente en Celo. Verifique en el buscador del módulo de Celos."
      @valido = false

    end
    
    Celo.transaction do

      if @valido
        
        @celo = Celo.new()
        @celo.ganado_id = params[:ganado_id]
        @celo.descripcion = params[:descripcion].upcase
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
              #AGREGAR HISTORIAL GANADO
              historial_ganado = HistorialGanado.new
              historial_ganado.ganado_id = params[:ganado_id]
              historial_ganado.modulo = "CELOS"
              historial_ganado.accion = "Ganado Marcado como en Celo"
              historial_ganado.fecha = Date.today
              historial_ganado.celo_id = @celo.id
              historial_ganado.observacion = params[:observacion]
              historial_ganado.save

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

  def editar
    
    @celo = Celo.find(params[:celo_id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

    @valido = true
    @msg = ""
    @guardado_ok = false

    @celo = Celo.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("actualizar celo ganado", "celos", @celo)

    if @valido
     
      @celo.fecha_inicio = params[:celo][:fecha_inicio]
      @celo.fecha_fin = params[:celo][:fecha_fin]
      @celo.descripcion = params[:celo][:descripcion].upcase
      @celo.observacion = params[:celo][:observacion]

        if @celo.save

          auditoria_despues(@celo, auditoria_id)
          @celo_ok = true
         
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

    valido = true
    @msg = ""

    Celo.transaction do

      @celo = Celo.find(params[:id])

      @celo_elim = @celo

      if valido

        #ELIMINAR HISTORIAL GANADO
        historial_ganado = HistorialGanado.where("celo_id = ?",@celo_elim.id).first
        historial_ganado.destroy


        if @celo.destroy

          auditoria_nueva("eliminar celo", "celos", @celo_elim)
          @ganado = Ganado.where("id = ?", @celo_elim.ganado_id).first
          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
          
          if @ganado.save

            @eliminado = true

          end
          
        end

      end

    end #end transaction
    
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


  def celos_detalles
    
    @celo_detalle = VCelo.where("celo_id = ?", params[:celo_id])


     respond_to do |f|

      f.js

    end
  
  end


  def cambiar_estado_a_en_reproduccion

    @celo = Celo.where("id = ?", params[:celo_id]).first



    respond_to do |f|

      f.js

    end

  end


  def guardar_cambiar_estado_a_en_reproduccion

    @guardado_ok = false
    @valido = true

    @celo = Celo.where("id = ?", params[:celo_id]).first
    auditoria_id_celo = auditoria_antes("actualizar estado del celo en guardar celo en reproduccion", "celos", @celo)
    @ganado = Ganado.where('id = ?', @celo.ganado_id).first
    auditoria_id_ganado = auditoria_antes("actualizar estado del ganado en guardar celo en reproduccion", "ganados", @ganado)
    
    if @valido

    Ganado.transaction do

      @reproduccion = Reproduccion.new
      @reproduccion.celo_id = params[:celo_id]
      @reproduccion.tipo_concepcion_id = params[:tipo_concepcion][:id]
      if params[:tipo_concepcion][:id].to_i == PARAMETRO[:tipo_concepcion_monta_natural].to_i

        @reproduccion.ganado_reproductor_id = params[:ganado_reproductor_id]

      else

        @reproduccion.esperma_id = params[:esperma_id]
        @reproduccion.inseminador = params[:nombre_inseminador]

      end

      @reproduccion.fecha_reproduccion = params[:fecha_reproduccion]
      @reproduccion.fecha_concepcion = params[:fecha_concepcion]
      @reproduccion.estado_reproduccion_id = PARAMETRO[:estado_reproduccion_proceso_fecundacion]
      @reproduccion.descripcion = params[:descripcion]
      @reproduccion.observacion = params[:observacion]

      if @reproduccion.save

        auditoria_nueva("agregar reproduccion en modulo de celos", "reproducciones", @reproduccion)
        @celo.estado_celo_id = PARAMETRO[:estado_celo_en_reproduccion]
        
        if @celo.save
         
          auditoria_despues(@celo, auditoria_id_celo)
          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_en_reproduccion]
          
          if @ganado.save

            auditoria_despues(@ganado, auditoria_id_ganado)
            @guardado_ok = true

          end

        end

        #AGREGAR HISTORIAL GANADO
        historial_ganado = HistorialGanado.new
        historial_ganado.ganado_id = @ganado.id
        historial_ganado.modulo = "REPRODUCCIONES"
        historial_ganado.accion = "Ganado Marcado como en Reproducción"
        historial_ganado.fecha = Date.today
        historial_ganado.celo_id = @celo.id
        historial_ganado.observacion = params[:observacion]
        historial_ganado.save

        
      end

    end # end transaction

    end

    respond_to do |f|

      f.js

    end

  end

  def cambiar_estado_a_celo_perdido

    @celo = Celo.where("id = ?", params[:celo_id]).first



    respond_to do |f|

      f.js

    end

  end


  def guardar_cambiar_estado_a_celo_perdido

    @guardado_ok = false
    @valido = true

    @celo = Celo.where("id = ?", params[:celo_id]).first
    auditoria_id_celo = auditoria_antes("actualizar estado del celo en guardar celo a perdido", "celos", @celo)
    @ganado = Ganado.where('id = ?', @celo.ganado_id).first
    auditoria_id_ganado = auditoria_antes("actualizar estado del ganado en guardar celo a perdido", "ganados", @ganado)
    
    if @valido
      
      @celo.estado_celo_id = PARAMETRO[:estado_celo_en_perdido]
      @celo.observacion = params[:observacion]

      if @celo.save
        
        auditoria_despues(@celo, auditoria_id_celo)
        @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
        
        if @ganado.save
          
          auditoria_despues(@ganado, auditoria_id_ganado)
          @guardado_ok = true

        end
        

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def buscar_ganado_reproductor

    @ganados = VGanado.modulo_ganados.where("nombre ilike ? and sexo_ganado_id = ? and etapa_ganado_id in (?)", "%#{params[:ganado]}%", params[:sexo_ganado_id], [PARAMETRO[:etapa_ganado_torito], PARAMETRO[:etapa_ganado_toro]])

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


   def buscar_esperma_reproductor

    @espermas = VEsperma.where("descripcion ilike ? and cantidad > 0 and estado_esperma_id = ?", "%#{params[:ganado]}%", PARAMETRO[:estado_esperma_activo])

    respond_to do |f|
      
      f.html
      f.json { render :json => @espermas }
    
    end

  end


end