module Api

    module V1

		class WebServiceUserController < ApplicationController
			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def create

  				persona = Persona.where("documento_persona = ? ",params[:username]).first

  				if persona.present?

  					login = "#{persona.documento_persona}-#{quita_acentos(persona.tipo_documento.descripcion.downcase[0..2])}-#{quita_acentos(persona.nacionalidad.descripcion.downcase[0..2])}" 
					puts "---------------------------------------"
					
					usuario_session = UsuarioSession.new( login: login, password: params[:password] )

				    if usuario_session.save
				    	
				    	#@response = Usuario.where("login = ? ", login)
				    	@response = Usuario.select("usuarios.id, usuarios.persona_id,usuarios.email,personas.nombre_persona, personas.documento_persona, false as rol_profesor").joins("join personas  on usuarios.persona_id = personas.id").where("usuarios.login = ? ", login)
				    	puts"******Acceso Correcto*****************"
				    	

				    else
				    	

				    	#login_sigmec = SigmecLogin.orden_id.where("documento_persona = ? and password_usuario = md5 (?)", params[:username], params[:password]).first
				    	
				    	#if login_sigmec.present?

				    	#	@response = SigmecLogin.select("id_usuario as id, id_persona as persona_id, correo_electronico_persona as email, nombre_usuario as nombre_persona, documento_persona, true as rol_profesor").orden_id.where("id_usuario = ?",login_sigmec.id_usuario)
				    	#	puts"******Acceso Correcto*****************"

				    	#else

				    		@response = {msg: "error"}
				    		puts "*********Password Incorrecto!!!**************"

				    	#end

				  	end
				  	
				else
					
					@response = {msg: "error"}
					puts "Usuario no válido"
					

				end
				
				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end

			 end

		end

	end

end	