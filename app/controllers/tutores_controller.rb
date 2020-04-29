class TutoresController < ApplicationController

before_filter :require_usuario


  def index
  

  end
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_tutor_id].present?

      cond << "tutor_id = ?"
      args << params[:form_buscar_tutor_id]

    end

    if params[:form_buscar_tutor_documento].present?

      cond << "documento_persona = ?"
      args << params[:form_buscar_tutor_documento]

    end

    if params[:form_buscar_tutor_nombre].present?

      cond << "nombre_persona ilike ?"
      args << "%#{params[:form_buscar_tutor_nombre]}%"

    end

    if params[:form_buscar_tutor_apellido].present?

      cond << "apellido_persona ilike ?"
      args << "%#{params[:form_buscar_tutor_apellido]}%"

    end

    if params[:form_buscar_tutor_direccion].present?

      cond << "direccion ilike ?"
      args << "%#{params[:form_buscar_tutor_direccion]}%"

    end

    if params[:form_buscar_tutor_telefono].present?

      cond << "telefono ilike ?"
      args << "%#{params[:form_buscar_tutor_telefono]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @tutores =  VTutor.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VTutor.where(cond).count

    else
     
      @tutores = VTutor.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VTutor.count

    end

    @total_registros = VTutor.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @tutor = VTutor.new

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
      
      @tutor = Tutor.new()
      @tutor.persona_id = params[:persona_id]

        if @tutor.save

          auditoria_nueva("registrar tutor", "tutores", @tutor)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4].to_s)
      
      end                
              
    respond_to do |f|
      
        f.js
      
    end

  end

  def editar
    
    @tutor = Persona.find(params[:id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

    valido = true
    @msg = ""

    @persona = Persona.find(params[:persona][:id])
    @tutor = Tutor.where("persona_id = ?", params[:persona][:id]).first
    auditoria_id = auditoria_antes("actualizar persona", "personas", @persona)

    if valido

      @persona.update_attributes(params[:persona] )
      auditoria_despues(@persona, auditoria_id)

      if @persona.save

        @persona_ok = true

      end
    
    end
    
    rescue Exception => exc  
      # dispone el mensaje de error 
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4])
      
      end                
        
    respond_to do |f|

      f.js

    end

  end

  def buscar_tutor
    
    @personas = VTutor.where("nombre_persona ilike ?", "%#{params[:cliente_produccion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

  def eliminar

    @valido = true
    @msg = ""

    @tutor = Tutor.find(params[:id])

    @tutor_elim = @tutor  

    if @valido

      if @tutor.destroy

        auditoria_nueva("eliminar tutor", "tutores", @tutor)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el tutor."

      end

    end

        rescue Exception => exc  
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
          
          @excep = exc.message.split(':')    
          @msg = @excep[3].concat(" "+@excep[4])
          @eliminado = false
        
        end
        
    respond_to do |f|

      f.js

    end

  end


  def buscar_persona
    
    if params[:tipo_documento_id].present? && params[:nacionalidad_id] && params[:documento].present?

      @persona = Persona.where("tipo_documento_id = ? and nacionalidad_id = ? and documento_persona = ?", params[:tipo_documento_id], params[:nacionalidad_id], params[:documento])  
 
    end

    respond_to do |f|

      f.json { render :json => @persona.first}

    end

  end


  def tutor_detalle
    
    @tutor_detalle = VTutorDetalle.where("tutor_id = ?", params[:tutor_id])


     respond_to do |f|

      f.js

    end
  
  end


  def agregar_tutor_detalle
    
    @tutor_detalle = TutorDetalle.new

   respond_to do |f|

      f.js

    end
  
  end


   def guardar_tutor_detalle
    
    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:persona_documento].present?

      @valido = false
      @msg += " Debe Completar el campo Documento. \n"

    end

    unless params[:persona_nombre].present?

      @valido = false
      @msg += " El nombre del Paciente no puede estar vacío. \n"

    end

    unless params[:parentezco][:id].present?

      @valido = false
      @msg += " El apellido del Paciente no puede estar vacío. \n"

    end

    if @valido
      
      @tutor_Detalle = TutorDetalle.new()
      @tutor_Detalle.tutor_id = params[:tutor_id]
      @tutor_Detalle.paciente_id = params[:paciente_id]
      @tutor_Detalle.parentezco_id = params[:parentezco][:id]

        if @tutor_Detalle.save

          auditoria_nueva("registrar paciente asignado a tutor", "tutores_detalles", @tutor_Detalle)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4].to_s)
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def eliminar_tutor_detalle

    @valido = true
    @msg = ""

    @tutor_detalle = TutorDetalle.find(params[:tutor_detalle_id])

    if @valido

      if @tutor_detalle.destroy

        auditoria_nueva("eliminar tutor detalle", "tutores_detalles", @tutor_detalle)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el detalle del Tutor. Intente más tarde."

      end

    end

        rescue Exception => exc  
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
          
          @excep = exc.message.split(':')    
          @msg = @excep[3].concat(" "+@excep[4])
          @eliminado = false
        
        end
        
    respond_to do |f|

      f.js

    end
  
  end


end