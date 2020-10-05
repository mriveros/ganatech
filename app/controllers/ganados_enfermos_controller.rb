class GanadosEnfermosController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_ganado_enfermo_id].present?

      cond << "ganado_enfermo_id = ?"
      args << params[:form_buscar_ganado_enfermo_id]

    end

    if params[:form_buscar_ganado_enfermo_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_ganado_enfermo_fecha]

    end

    if params[:form_buscar_ganado_enfermo_codigo].present?

      cond << "ganado_rfid = ?"
      args << params[:form_buscar_ganado_enfermo_codigo]

    end

    if params[:form_buscar_ganado_enfermo_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_nombre]}%"

    end

    if params[:form_buscar_ganado_enfermo_ganado_rp].present?

      cond << "ganado_rp  ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_ganado_rp]}%"

    end

    if params[:form_buscar_ganado_enfermo][:enfermedad_id].present?

      cond << "enfermedad_id = ?"
      args << params[:form_buscar_ganado_enfermo][:enfermedad_id]

    end

    if params[:form_buscar_ganado_enfermo][:estado_enfermedad_id].present?

      cond << "estado_enfermedad_id = ?"
      args << params[:form_buscar_ganado_enfermo][:estado_enfermedad_id]

    end

    if params[:form_buscar_ganado_enfermo_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_ganado_enfermo_observacion]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados_enfermos =  VGanadoEnfermo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEnfermo.where(cond).count

    else
     
      @ganados_enfermos = VGanadoEnfermo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEnfermo.count

    end

    @total_registros = VGanadoEnfermo.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def ganado_enfermo_detalle

    @ganado_detalle = Ganado.where("id = ?", params[:ganado_id]).first
    @control_sanitario = VControlGanado.orden_fecha.where("ganado_enfermo_id =?", params[:ganado_enfermo_id]).paginate(per_page: 5, page: params[:page])

    respond_to do |f|

      f.js

    end

  end
 
  def eliminar

    @eliminado = false
    @msg = ""
    @valido = true

    @control_ganado = ControlGanado.where("ganado_enfermo_id = ?", params[:ganado_enfermo_id])

    if @control_ganado.present?

      @valido = false
      @msg = "Este Ganado ya cuenta con detalles de tratamiento."
    
    else

      @valido = true

    end

    if @valido

      @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first
      @ganado_enfermo_elim = @ganado_enfermo
      
      if @ganado_enfermo.destroy
        
        @ganado = Ganado.where("id = ?", @ganado_enfermo.ganado_id).first
        auditoria_id = auditoria_antes("Eliminar ganado del modulo de ganados enfermos","ganados",@ganado)
        @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]

        if @ganado.save

          auditoria_despues(@ganado,auditoria_id)
          @eliminado = true

        end

      end

    end
    
    respond_to do |f|

      f.js

    end

  end

  def editar_ganado_enfermo

    @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first

    respond_to do |f|

      f.js

    end

  end

  def actualizar_ganado_enfermo

   @valido = true
   @msg = ""
   @actualizado_ok = false

    unless params[:ganado_enfermo][:estado_enfermedad_id].present?

      @valido = false
      @msg = "Debe seleccionar el estado de la enfermedad."

    end
    
    if @valido

      @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first
      @ganado_enfermo.estado_enfermedad_id = params[:ganado_enfermo][:estado_enfermedad_id]
      @ganado_enfermo.observacion = params[:ganado_enfermo][:observacion]

      if @ganado_enfermo.save

        @actualizado_ok = true

      end

    end

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
      @control_ganado.ganado_enfermo_id = params[:ganado_enfermo_id]

        if @control_ganado.save

          auditoria_nueva("agregar control sanitario en modulo de ganados enfermos", "controles_ganados", @control_ganado)
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


  def cambiar_estado_a_recuperado

    @actualizado_ok = false

    @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first
    @ganado_enfermo.estado_enfermedad_id = PARAMETRO[:estado_enfermedad_curado]
    
    if @ganado_enfermo.save

      auditoria_nueva("Cambiar el estado del ganado enfermo a recuperado","ganados_enfermos", @ganado_enfermo )
      @ganado = Ganado.where("id = ?", @ganado_enfermo.ganado_id).first
      auditoria_id = auditoria_antes("Cambiar estado en el modulo de ganados enfermos","ganados", @ganado)
      @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
      if @ganado.save

        auditoria_despues(@ganado, auditoria_id )
        @actualizado_ok = true

      end

    end

    respond_to do |f|

      f.js

    end

  end


  def cambiar_estado_a_muerto

    @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first

    respond_to do |f|

      f.js

    end

  end


  def guardar_estado_ganado_muerto

    @actualizado_ok = false


    @ganado_enfermo = GanadoEnfermo.where("id = ?", params[:ganado_enfermo_id]).first

    DocumentoGanatec.transaction do 

        @documento_ganatec = DocumentoGanatec.new
        @documento_ganatec.numero = params[:numero]
        @documento_ganatec.descripcion = params[:descripcion]
        @documento_ganatec.fecha_emision = params[:fecha]
        @documento_ganatec.tipo_resolucion_id = PARAMETRO[:tipo_resolucion_ganado_muerto]
        @documento_ganatec.data = params[:data]

        if @documento_ganatec.save

          auditoria_nueva("agregar documento nuevo en ganatec, modulo de ganados enfermos", "documentos_ganatec", @documento_ganatec)

          @ganado_enfermo.documento_ganatec_id = @documento_ganatec.id
          @ganado_enfermo.estado_enfermedad_id = PARAMETRO[:estado_enfermedad_muerto]

          if @ganado_enfermo.save

            @ganado = Ganado.where("id = ?", @ganado_enfermo.ganado_id).first
            auditoria_id = auditoria_antes("Marcar Ganado como muerto, modulo ganados_enfermos","ganados", @ganado)
            @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_muerto]
            
            if @ganado.save

              auditoria_despues(@ganado,auditoria_id)
              
              @ganado_muerto = GanadoMuerto.new
              @ganado_muerto.ganado_id = @ganado.id
              @ganado_muerto.motivo_muerte_id = PARAMETRO[:motivo_muerte_enfermedad] 
              @ganado_muerto.fecha = params[:fecha]
              @ganado_muerto.observacion = params[:observacion]

              if @ganado_muerto.save

                @actualizado_ok = true

              end

            end

         end

        end

      end #end transaction    
    
    respond_to do |f|

      f.js

    end
    
  end


end