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

    if params[:form_buscar_reproduccion_fecha_reproduccion].present?

      cond << "fecha_reproduccion = ?"
      args << params[:form_buscar_reproduccion_fecha_inicio]

    end

    if params[:form_buscar_reproduccion_fecha_concepcion].present?

      cond << "fecha_concepcion = ?"
      args << params[:form_buscar_reproduccion_fecha_concepcion]

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

    if params[:form_buscar_reproduccion][:tipo_concepcion_id].present?

      cond << "tipo_concepcion_id = ?"
      args << params[:form_buscar_reproduccion][:tipo_concepcion_id]

    end

    if params[:form_buscar_reproduccion][:estado_reproduccion_id].present?

      cond << "estado_reproduccion_id = ?"
      args << params[:form_buscar_reproduccion][:estado_reproduccion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @reproducciones =  VReproduccion.fecha_creacion.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VReproduccion.where(cond).count

    else
     
      @reproducciones = VReproduccion.fecha_creacion.paginate(per_page: 10, page: params[:page])
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

    @guardado_ok = false
    @valido = true

    @ganado = Ganado.where('id = ?',params[:ganado_id]).first
    auditoria_id_ganado = auditoria_antes("actualizar estado del ganado en guardar celo en reproduccion", "ganados", @ganado)
    @celo = Celo.where("ganado_id = ? and estado_celo_id = ?", @ganado.id, PARAMETRO[:estado_celo_en_celo_activo]).first
    auditoria_id_celo = auditoria_antes("actualizar estado del celo en guardar celo en reproduccion", "celos", @celo)
    unless @celo.present?

      @msg = " El Ganado no está en Celo. Debe marcar este ganado en Celo para agregar en Reproducción."

    end

    if @valido

    Ganado.transaction do

      @reproduccion = Reproduccion.new
      @reproduccion.celo_id = @celo.id
      @reproduccion.tipo_concepcion_id = params[:tipo_concepcion][:id]
      if params[:tipo_concepcion][:id].to_i == PARAMETRO[:tipo_concepcion_monta_natural].to_i

        @reproduccion.ganado_reproductor_id = params[:ganado_reproductor_id]

      else

        @reproduccion.esperma_id = params[:esperma_id]
        @reproduccion.inseminador = params[:inseminador]

      end

      @reproduccion.fecha_reproduccion = params[:fecha_reproduccion]
      @reproduccion.fecha_concepcion = params[:fecha_concepcion]
      @reproduccion.estado_reproduccion_id = PARAMETRO[:estado_reproduccion_proceso_fecundacion]
      @reproduccion.descripcion = params[:descripcion].upcase
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


 def eliminar

    valido = true
    @msg = ""

    Reproduccion.transaction do

      @reproduccion = Reproduccion.find(params[:id])

      @reproduccion_elim = @reproduccion

      if valido

        if @reproduccion.destroy

          auditoria_nueva("eliminar reproduccion", "reproducciones", @reproduccion_elim)
          @celo = Celo.where("id = ?", @reproduccion.celo_id).first
          auditoria_id_celo = auditoria_antes("cambiar estado celo", "celos", @celo)
          @celo.estado_celo_id = PARAMETRO[:estado_celo_en_celo_activo]
          
          if @celo.save

            auditoria_despues(@celo, auditoria_id_celo)
            @ganado = Ganado.where("id = ?", @celo.ganado_id).first
            auditoria_id_ganado = auditoria_antes("cambiar estado ganado", "ganados", @ganado)
            @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_en_celo]
          
            if @ganado.save

              auditoria_despues(@celo, auditoria_id_ganado)
              @eliminado = true

            end

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


  def reproducciones_detalles
    
    @reproduccion_detalle = VReproduccion.where("reproduccion_id = ?", params[:reproduccion_id]).first
    
     respond_to do |f|

      f.js

    end
  
  end


  def cambiar_estado_reproduccion

    @guardado_ok = false
    @valido = true

    if @valido

      Ganado.transaction do

        @reproduccion = Reproduccion.where("id = ?", params[:reproduccion_id]).first
        auditoria_id_reproduccion = auditoria_antes("cambiar estado reproduccion", "reproducciones", @reproduccion)

        @reproduccion.estado_reproduccion_id = PARAMETRO[:estado_reproduccion_prenhez]
        
        if @reproduccion.save

          auditoria_despues(@reproduccion, auditoria_id_reproduccion)
          celo = Celo.where("id = ?", @reproduccion.celo_id).first
          @ganado = Ganado.where("id = ?", celo.ganado_id).first
          auditoria_id_ganado = auditoria_antes("cambiar estado ganado", "ganados", @ganado)
          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_prenhado]
          
          if @ganado.save

            auditoria_despues(@ganado, auditoria_id_ganado)
            @guardado_ok = true

          end

        end

      end

    end

    respond_to do |f|

      f.js

    end

  end


  def cambiar_estado_reproduccion_a_reproduccion_finalizada

    @reproduccion = VReproduccion.where("reproduccion_id = ?", params[:reproduccion_id]).first

    ultima_produccion = Ganado.order("created_at").last

    if ultima_produccion.present?

      @codigo_lote = ultima_produccion.codigo_lote + 1

      if ultima_produccion.created_at.year != Time.now.year

        @nuevo_autoincremento = "RP-0" + 1.to_s

      else

         @nuevo_autoincremento = "RP-0" + (ultima_produccion.id + 1).to_s 

      end 

    else

      @codigo_lote = 1
      @nuevo_autoincremento = 1

    end



    respond_to do |f|

      f.js

    end

  end


  def guardar_estado_reproduccion_a_reproduccion_finalizada

    @guardado_ok = false
    @valido = true

    Ganado.transaction do

      @celo = Celo.where("id = ?", params[:celo_id]).first
      @ganado_madre = Ganado.where('id = ?', @celo.ganado_id).first
      auditoria_id_ganado_madre = auditoria_antes("actualizar estado del ganado en guardar celo en reproduccion", "ganados", @ganado_madre)
      @reproduccion = Reproduccion.where("id = ?", params[:reproduccion_id]).first
      auditoria_id_reproduccion = auditoria_antes("finalizar reproduccion", "reproducciones", @reproduccion)
      
      if @valido

          ganado = Ganado.new
          unless params[:nombre_ganado].present?
            
            ganado.nombre = params[:ganado_rp]

          else

            ganado.nombre = params[:nombre_ganado]

          end
          ganado.rp = params[:ganado_rp]
          ganado.codigo_lote = params[:codigo_lote]

          if @reproduccion.tipo_concepcion_id == PARAMETRO[:tipo_concepcion_monta_natural]

            @ganado_padre = Ganado.where("id = ?", @reproduccion.ganado_reproductor_id).first
            ganado.rp_padre = @ganado_padre.rp
          
          else
            #INSEMINACION ARTIFICIAL
            @esperma = Esperma.where("id = ?", @reproduccion.esperma_id).first

            if @esperma.esperma_procedencia_id == PARAMETRO[:esperma_local]

              @ganado_padre = Ganado.where("id = ?", @esperma.ganado_id).first
              ganado.rp_padre = @ganado_padre.rp

            end


          end
          
          ganado.rp_madre = @ganado_madre.rp
          ganado.codigo_rfid = params[:codigo_rfid]
          ganado.potrero_id = @ganado_madre.potrero_id
          ganado.peso_promedio = params[:peso_promedio]
          ganado.tipo_ganado_id = @ganado_madre.tipo_ganado_id
          ganado.raza_id = params[:v_reproduccion][:celo_ganado_raza_id]
          ganado.tipo_concepcion_id = @reproduccion.tipo_concepcion_id
          ganado.reproduccion_id = @reproduccion.id
          ganado.observacion = params[:observacion]
          ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
          ganado.sexo_ganado_id = params[:sexo_ganado][:id]

          if params[:sexo_ganado][:id].to_i == PARAMETRO[:sexo_ganado_macho]
          
            ganado.etapa_ganado_id = PARAMETRO[:etapa_ganado_ternero]

          else

            ganado.etapa_ganado_id = PARAMETRO[:etapa_ganado_ternera]

          end

          ganado.fecha_nacimiento = params[:fecha_concepcion]
          ganado.finalidad_ganado_id = PARAMETRO[:finalidad_ganado_no_especificado]

          if ganado.save

            auditoria_nueva("agregar nuevo ganado de modulo reproduccion", "ganados", ganado)
            @ganado_madre.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
            
            if @ganado_madre.save

              auditoria_despues(@ganado_madre, auditoria_id_ganado_madre)
              @reproduccion.estado_reproduccion_id = PARAMETRO[:estado_reproduccion_finalizado]
              @reproduccion.fecha_concepcion = params[:fecha_concepcion]

              if @reproduccion.save

                auditoria_despues(@reproduccion, auditoria_id_reproduccion)
                @guardado_ok = true

                #Notificar usuarios email
                modulo = 'Módulo Reproducciones'
                subject = 'Reprodución Finalizada(Nuevo Ganado)'
                adjunto =  'Ganado Nombre: ' + ganado.nombre + ' RP: ' + ganado.rp
                NotificarUsuario.test_email(current_usuario.id, subject, adjunto, modulo).deliver

                notificaciones_personas = NotificacionPersona.where('estado = ?', true)
                notificaciones_personas.each do |nu|

                  NotificarUsuario.enviar_notificacion(nu.email,subject ,adjunto,modulo).deliver

                end

              end

            end


          end

      end

    end # end transaction
    respond_to do |f|

      f.js

    end

  end

  def cambiar_estado_reproduccion_a_reproduccion_perdido

    @reproduccion = Reproduccion.where("id = ?", params[:reproduccion_id]).first

    respond_to do |f|

      f.js

    end

  end


  def guardar_estado_reproduccion_a_reproduccion_perdido

    @guardado_ok = false
    @valido = true

   Ganado.transaction do 

      if @valido

        @reproduccion = Reproduccion.where("id = ?", params[:reproduccion_id]).first
        auditoria_id_reproduccion = auditoria_antes("actualizar estado de reproduccion a reproduccion perdido", "reproducciones", @Reproducción)
        celo = Celo.where("id = ?", @reproduccion.celo_id).first
        @ganado = Ganado.where('id = ?', celo.ganado_id).first
        auditoria_id_ganado = auditoria_antes("actualizar estado del ganado en guardar reproduccion a perdido", "ganados", @ganado)
      
        
        @reproduccion.estado_reproduccion_id = PARAMETRO[:estado_reproduccion_perdido]
        @reproduccion.observacion = params[:observacion]
        @reproduccion.fecha_aborto = params[:fecha_aborto]
        @reproduccion.tipo_aborto_id = params[:reproduccion][:tipo_aborto_id]

        if @reproduccion.save
          
          auditoria_despues(@reproduccion, auditoria_id_reproduccion)
          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
          
          if @ganado.save
            
            auditoria_despues(@ganado, auditoria_id_ganado)
            @guardado_ok = true

            #Notificar usuarios email
            tipo_aborto = TipoAborto.where('id = ?', params[:reproduccion][:tipo_aborto_id]).first
            modulo = 'Módulo Reproducciones'
            subject = 'Reprodución Perdida(Aborto)'
            adjunto =  'Ganado Nombre: ' + @ganado.nombre + ' RP: ' + @ganado.rp + ' Tipo Aborto: ' + tipo_aborto.descripcion.to_s + ' Fecha: ' + params[:fecha_aborto]
            NotificarUsuario.test_email(current_usuario.id, subject, adjunto, modulo).deliver

            notificaciones_personas = NotificacionPersona.where('estado = ?', true)
            notificaciones_personas.each do |nu|

                NotificarUsuario.enviar_notificacion(nu.email,subject ,adjunto,modulo).deliver

            end

          end
          
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

  def buscar_ganado_estado_celo

    @ganados = VGanado.where("nombre ilike ? and estado_ganado_id = ?", "%#{params[:ganado]}%", PARAMETRO[:estado_ganado_en_celo])
    
    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


end