class NotificacionesUsuariosController < ApplicationController

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

	      @notificaciones =  VNotificacionUsuario.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VNotificacionUsuario.where(cond).count

	    else

	      @notificaciones = VNotificacionUsuario.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VNotificacionUsuario.count

	    end

	    @total_registros = VNotificacionUsuario.count

	    respond_to do |f|

	      f.js

	    end

	  end


	  def agregar

	    @notificacion_usuario = NotificacionUsuario.new

	    respond_to do |f|

	      f.js

	    end

	  end


	  def guardar

	    valido = true
	    @msg = ""

	    @notificacion_usuario = NotificacionUsuario.new()

	    @notificacion_usuario.descripcion = params[:NotificacionUsuario][:descripcion].upcase
	    @notificacion_usuario.sueldo = params[:NotificacionUsuario][:sueldo].to_s.gsub(/[$.]/,'').to_i
	    
	      if @notificacion_usuario.save

	        auditoria_nueva("registrar NotificacionUsuario", "notificaciones", @notificacion_usuario)
	       
	        @notificacion_usuario_ok = true
	       

	      end              
	               
	    respond_to do |f|

	      f.js

	    end

	  end


	  def eliminar

	    valido = true
	    @msg = ""

	    @notificacion_usuario = NotificacionUsuario.find(params[:id])
		@notificacion_usuario_elim = @notificacion_usuario

	    if valido

	      	if @notificacion_usuario.destroy

		        auditoria_nueva("eliminar NotificacionUsuario", "notificaciones", @notificacion_usuario)
		        @eliminado = true

	    	end
		end

	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @notificacion_usuario = NotificacionUsuario.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @notificacion_usuario =Cargo NotificacionUsuario.find(params[:NotificacionUsuario][:id])
	    auditoria_id = auditoria_antes("actualizar NotificacionUsuario", "notificaciones", @notificacion_usuario)

	    if valido

	      
	    	@notificacion_usuario.descripcion = params[:NotificacionUsuario][:descripcion].upcase
	    	@notificacion_usuario.sueldo = params[:NotificacionUsuario][:sueldo].to_s.gsub(/[$.]/,'').to_i
	      	
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