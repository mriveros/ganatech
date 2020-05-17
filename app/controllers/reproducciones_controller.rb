class ReproduccionesController < ApplicationController

before_filter :require_usuario


  def index
  

  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_reproduccion_id].present?

      cond << "reproduccion_id = ?"
      args << params[:form_buscar_reproduccion_id]

    end

    if params[:form_buscar_reproduccion_ganado_rfid].present?

      cond << "celo_ganado_rfid = ?"
      args << params[:form_buscar_reproduccion_ganado_rfid]

    end

    if params[:form_buscar_reproduccion_ganado_nombre].present?

      cond << "celo_ganado_nombre  ilike ?"
      args << "%#{params[:form_buscar_reproduccion_ganado_nombre]}%"

    end

    if params[:form_buscar_reproduccion_ganado_rp].present?

      cond << "celo_ganado_rp = ?"
      args << params[:form_buscar_reproduccion_ganado_rp]

    end

    if params[:form_buscar_reproduccion_fecha_inicio].present?

      cond << "fecha_inicio = ?"
      args << params[:form_buscar_reproduccion_fecha_inicio]

    end

    if params[:form_buscar_reproduccion_fecha_fin].present?

      cond << "fecha_fin = ?"
      args << params[:form_buscar_reproduccion_fecha_fin]

    end

    if params[:form_buscar_reproduccion_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_reproduccion_descripcion]}%"

    end

    if params[:form_buscar_reproduccion][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_reproduccion][:hacienda_id]

    end

    if params[:form_buscar_reproduccion][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_reproduccion][:hacienda_id]

    end

    if params[:form_buscar_reproduccion][:estado_reproduccion_id].present?

      cond << "estado_reproduccion_id = ?"
      args << params[:form_buscar_reproduccion][:estado_celo_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @reproducciones =  VReproduccion.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VReproduccion.where(cond).count

    else
     
      @reproducciones = VReproduccion.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VReproduccion.count

    end

    @total_registros = VReproduccion.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @reproduccion = Reproduccion.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    @ganado = Ganado.where("id = ?", params[:ganado_id]).first
    auditoria_id_ganado = auditoria_antes("actualizar estado del ganado en guardar reproduccion", "ganados", @ganado)

    @celo = Celo.where("id = ? ", params[:celo_id]).first
    auditoria_id_celo = auditoria_antes("actualizar estado del celo en guardar reproduccion", "celos", @celo)

    
    Reproduccion.transaction do

      if @valido
        
        @reproduccion = Reproduccion.new()
        @reproduccion.celo_id = params[:celo_id]
        @reproduccion.descripcion = params[:descripcion]
        @reproduccion.observacion = params[:observacion]
        @reproduccion.fecha_reproduccion = params[:fecha_reproduccion]
        @reproduccion.fecha_concepcion = params[:fecha_concepcion]
        
        if params[:tipo_concepcion_id] == PARAMETRO[:tipo_concepcion_monta_natural]

          @reproduccion.tipo_concepcion_id = params[:tipo_concepcion_id]
          @reproduccion.ganado_reproductor_id = params[:ganado_reproductor_id]

        else
           
          @reproduccion.tipo_concepcion_id = params[:tipo_concepcion_id]
          @reproduccion.esperma_id = params[:esperma_id]

        end
        
        @reproduccion.estado_reproduccion_id = PARAMETRO[:estado_reproduccion_proceso_fecundacion]

        if @reproduccion.save

            auditoria_nueva("agregar nueva reproduccion", "reproducciones", @reproduccion)
            #cambiamos el estado del celo
            @celo.estado_celo_id = PARAMETRO[:estado_celo_en_reproduccion]  
            
            if @celo.save

              auditoria_despues(@ganado, auditoria_id_celo)
              #cambiamos el estado del ganado
              @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_en_reproduccion]
              
              if @ganado.save

                @guardado_ok = true
                auditoria_despues(@ganado, auditoria_id_ganado)

              end

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
    
    @reproduccion = Reproduccion.find(params[:reproduccion_id])

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

    @ganados = VGanado.where("nombre ilike ? and sexo_ganado_id = ? and etapa_ganado_id in (?)", "%#{params[:ganado]}%", params[:sexo_ganado_id], [PARAMETRO[:etapa_ganado_torito], PARAMETRO[:etapa_ganado_toro]])

    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


   def buscar_esperma_reproductor

    @espermas = VEsperma.where("descripcion ilike ? and cantidad > 0", "%#{params[:ganado]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @espermas }
    
    end

  end


end