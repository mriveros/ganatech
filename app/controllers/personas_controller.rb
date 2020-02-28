class PersonasController < ApplicationController

	before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_personas_id].present?

      cond << "personas.id = ?"
      args << params[:form_buscar_personas_id]

    end

    if params[:form_buscar_personas_nacionalidad_id].present?

      cond << "personas.nacionalidad_id = ?"
      args << params[:form_buscar_personas_nacionalidad_id]

    end

    if params[:form_buscar_personas_tipo_documento_id].present?

      cond << "personas.tipo_documento_id = ?"
      args << params[:form_buscar_personas_tipo_documento_id]

    end

    if params[:form_buscar_personas_documento_persona].present?

      cond << "personas.documento_persona = ?"
      args << params[:form_buscar_personas_documento_persona]

    end

    if params[:form_buscar_personas_nombre_persona].present? && params[:form_buscar_personas_apellido_persona].present?
      cond << "personas.nombre_persona=trim(upper(sin_acentos('#{params[:form_buscar_personas_nombre_persona]}'))) and personas.apellido_persona=trim(upper(sin_acentos('#{params[:form_buscar_personas_apellido_persona]}')))"
    end

    if params[:form_buscar_personas_fecha_nacimiento].present?

      cond << "personas.fecha_nacimiento = ?"
      args << params[:form_buscar_personas_fecha_nacimiento]

    end

    if params[:form_buscar_personas] && params[:form_buscar_personas][:sexo_id].present?

      cond << "personas.genero_id = ?"
      args << params[:form_buscar_personas][:genero_id]

    end


    if params[:form_buscar_personas] && params[:form_buscar_personas][:estado_civil_id].present?

      cond << "personas.estado_civil_id = ?"
      args << params[:form_buscar_personas][:estado_civil_id]

    end

    if params[:form_buscar_personas_libro].present?

      cond << "libro=?"
      args << "#{params[:form_buscar_personas_libro]}"

    end

    if params[:form_buscar_personas_folio].present?

      cond << "folio=?"
      args << "#{params[:form_buscar_personas_folio]}"

    end

    if params[:form_buscar_personas_acta].present?

      cond << "acta=?"
      args << "#{params[:form_buscar_personas_acta]}"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @personas =  Persona.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      #@total_encontrados = Persona.where(cond).count

    else

      @personas = Persona.orden_01.paginate(per_page: 10, page: params[:page])
      #@total_encontrados = Persona.count

    end

    #@total_registros = Persona.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @persona = Persona.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""

    @persona = Persona.new(params[:persona])

    if @persona.tipo_documento_id == PARAMETRO[:certificado_nacimiento] || @persona.tipo_documento_id == PARAMETRO[:sin_documento]

      id_mayor = "*" + (Persona.maximum(:id) + 1).to_s

      @persona.documento_persona = id_mayor

    end

      if @persona.save

        auditoria_nueva("registrar persona", "personas", @persona)
       
        @persona_ok = true
      
 

      end 
  #  end
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

  def eliminar

    valido = true
    @msg = ""

    @persona = Persona.find(params[:id])

    usuarios = Usuario.where("persona_id = ?", @persona.id)

    if usuarios.present?

      valido = false
      @msg = "Imposible eliminar... tiene usuarios relacionados.<br />"

    end

    if valido

      if @persona.destroy

        auditoria_nueva("eliminar persona", "personas", @persona)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el persona."

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

  def editar

    @persona = Persona.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @persona = Persona.find(params[:persona][:id])
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
  
  
  def mostrar_formulario
    puts "Imprimir id de persona"
    puts params[:persona_id]
    
    @persona_unificar = Persona.find_by_id(params[:persona_id])
    puts "************************************************"
    puts @persona_unificar.id
   
    respond_to do |f|

      f.js

    end
  end
  
  def unificar_persona
    @guardado_ok = false
    puts "persona raiz"
    puts params[:persona_id]
    puts "persona seleccionada"
    puts params[:id][:persona_id]
     if ActiveRecord::Base.connection.execute("select personas_unificar(#{params[:id][:persona_id]},#{params[:persona_id]});")
       @guardado_ok = true
       if @guardado_ok
        persona_seleccionada = Persona.find(params[:id][:persona_id])
        auditoria_id = auditoria_antes("unificar_persona", "personas", persona_seleccionada)
        persona_raiz = Persona.find(params[:persona_id])
        auditoria_despues(persona_raiz, auditoria_id)
       end
     end
     rescue Exception => exc
      @generado = false
      @excep = exc.message.split(':')
      @msg = @excep[3].to_s.concat(" "+@excep[4].to_s)
    
    respond_to do |f|

      f.js  
    end

  end
  
  def obtener_datos
    @persona= Persona.find_by_id(params[:persona_id])
    
    respond_to do |f|  
      f.html
      f.json { render :json => @persona }
    end
  end

  def agregar_persona_senatics

    respond_to do |f|
      f.js
    end

  end

  def buscar_persona_senatics

    respuesta = []

    if params[:documento_persona].present?

      documento = params[:documento_persona].gsub(" ", "").gsub(",","").gsub(".","").gsub(";","")

      persona = Persona.where("documento_persona = ? and tipo_documento_id = 1", documento ).first

      if persona.present?

        nacionalidad = Nacionalidad.find(persona.nacionalidad_id)

        respuesta << 1
        respuesta << persona.documento_persona
        respuesta << persona.nombre_persona
        respuesta << persona.apellido_persona
        respuesta << persona.fecha_nacimiento
        respuesta << nacionalidad.descripcion
        respuesta << (persona.genero_id == 1 ? 'Femenino' : 'Masculino') 

      else


      end

    else

      respuesta << 0

    end

    respond_to do |f|  

      f.html
      f.json { render :json => respuesta }

    end

  end


  def buscar_chofer
    
    @personas = Persona.where("nombre_persona ilike ?", "%#{params[:chofer_produccion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

end
