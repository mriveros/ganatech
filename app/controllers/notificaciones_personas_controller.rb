class NotificacionesPersonasController < ApplicationController

	before_filter :require_usuario

	  def index


	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_notificaciones_id].present?

	      cond << "id = ?"
	      args << params[:form_buscar_notificaciones_id]

	    end

	    if params[:form_buscar_notificaciones_usuarios_descripcion].present?

	      cond << "descripcion ilike ?"
	      args << "%#{params[:form_buscar_notificaciones_usuarios_descripcion]}%"

	    end

	    if params[:form_buscar_notificaciones_usuarios_nombre_persona].present?

	      cond << "nombre_persona ilike ?"
	      args << "%#{params[:form_buscar_notificaciones_usuarios_nombre_persona]}%"

	    end

	    if params[:form_buscar_notificaciones_usuarios_apellido_persona].present?

	      cond << "apellido ilike ?"
	      args << "%#{params[:form_buscar_notificaciones_usuarios_apellido_persona]}%"

	    end

	    if params[:form_buscar_notificaciones_usuarios_email].present?

	      cond << "email ilike ?"
	      args << "%#{params[:form_buscar_notificaciones_usuarios_email]}%"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @notificaciones_personas =  VNotificacionPersona.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VNotificacionPersona.where(cond).count

	    else

	      @notificaciones_personas = VNotificacionPersona.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VNotificacionPersona.count

	    end

	    @total_registros = VNotificacionPersona.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @notificacion_persona = NotificacionPersona.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    @valido = true
	    @msg = ""

	    persona = Persona.where("id = ?", params[:persona_id]).first
	    
	    unless persona.present?

	    	@valido = false
	    	@msg = "La persona no existe. "

	   	end

	   	unless params[:email].present?
	   		
	   		@valido = false
	    	@msg = "Debe agregar un email. "

	   	end

	   	if @valido
	    
		    @notificacion_persona = NotificacionPersona.new()
		    @notificacion_persona.descripcion = params[:descripcion]
		    @notificacion_persona.persona_id = params[:persona_id]
		    @notificacion_persona.email = params[:email]
		    
		    if @notificacion_persona.save

		      auditoria_nueva("registrar Notificacion Persona", "notificaciones_personas", @notificacion_persona)
		      @notificacion_persona_ok = true
		       

		    end   

	    end           
	             

	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @notificacion_persona = NotificacionPersona.find(params[:id])
		@notificacion_persona_elim = @notificacion_persona

	    if valido

	      	if @notificacion_persona.destroy

		        auditoria_nueva("eliminar Notificacion Persona", "notificaciones_persona", @notificacion_persona)
		        @eliminado = true

	    	end

		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @notificacion_persona = NotificacionPersona.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    @valido = true
	    @msg = ""

	    @notificacion_persona = NotificacionPersona.find(params[:notificacion_persona][:id])
	    auditoria_id = auditoria_antes("actualizar Notificacion Persona", "notificaciones_personas", @notificacion_persona)

	    unless params[:notificacion_persona][:email].present?
	   		
	   		@valido = false
	    	@msg = "Debe agregar un email. "

	   	end

	    if @valido

	      
	    	@notificacion_persona.descripcion = params[:notificacion_persona][:descripcion].upcase
	    	@notificacion_persona.email = params[:notificacion_persona][:email]
	    	@notificacion_persona.estado = params[:notificacion_persona][:estado]
	      	
	      	if @notificacion_persona.save

	      		auditoria_despues(@notificacion_persona, auditoria_id)
	        	@notificacion_persona_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end