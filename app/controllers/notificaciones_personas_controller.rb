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

	      @notificaciones =  VNotificacionPersona.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VNotificacionPersona.where(cond).count

	    else

	      @notificaciones = VNotificacionPersona.orden_01.paginate(per_page: 10, page: params[:page])
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

	    	valido = false
	    	@msg = "La persona no existe."

	   	end

	   	if @valido
	    
		    @notificacion_usuario = NotificacionPersona.new()
		    @notificacion_usuario.descripcion = params[:notificacionPersona][:descripcion].upcase
		    @notificacion_persona.persona_id = params[:persona_id]
		    
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

	    @notificacion_usuario = NotificacionPersona.find(params[:id])
		@notificacion_usuario_elim = @notificacion_usuario

	    if valido

	      	if @notificacion_usuario.destroy

		        auditoria_nueva("eliminar NotificacionPersona", "notificaciones", @notificacion_usuario)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @notificacion_usuario = NotificacionPersona.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @notificacion_usuario =Cargo NotificacionPersona.find(params[:NotificacionPersona][:id])
	    auditoria_id = auditoria_antes("actualizar NotificacionPersona", "notificaciones", @notificacion_usuario)

	    if valido

	      
	    	@notificacion_usuario.descripcion = params[:NotificacionPersona][:descripcion].upcase
	    	@notificacion_usuario.sueldo = params[:NotificacionPersona][:sueldo].to_s.gsub(/[$.]/,'').to_i
	      	
	      	if @notificacion_usuario.save

	      		auditoria_despues(@notificacion_usuario, auditoria_id)
	        	@notificacion_usuario_ok = true

	      end

	    end           
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end