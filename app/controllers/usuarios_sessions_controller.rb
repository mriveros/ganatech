class UsuariosSessionsController < ApplicationController
    
  before_filter :require_usuario, :only => :destroy

  def matenimiento


  end

  def new
    @usuario_session = UsuarioSession.new
    #redirect_to usuarios_sessions_mantenimiento_path
  end

  def create
    
    persona = Persona.where("documento_persona = ? and tipo_documento_id = ? and nacionalidad_id = ?", params[:persona_documento], params[:persona][:tipo_documento_id], params[:persona][:nacionalidad_id])

    if persona.present?

      persona = persona.first

      @usuario_session = UsuarioSession.new(params[:usuario_session])
      @usuario_session.login = "#{persona.documento_persona}-#{quita_acentos(persona.tipo_documento.descripcion.downcase[0..2])}-#{quita_acentos(persona.nacionalidad.descripcion.downcase[0..2])}"
    
      if @usuario_session.save

        perfil = Perfil.where("usuario_id = ? and rol_id = ?", current_usuario.id, params[:perfil][:rol_id]).first if params[:perfil] && params[:perfil][:rol_id].present?
				

        if perfil.present?
					
					puts "////////////////ACCEDE A LOGIN////////////////"
          
          
          current_usuario.perfil_actual_id = perfil.id
          current_usuario.save
        
          flash[:notice] = "Usuario autenticado exitosamente!!"
          #redirect_to root_path
          
          
          if perfil.rol_id == PARAMETRO[:rol_estudiante_superior]
            
            redirect_to :matriculaciones_superior_index
            
          else
            
            redirect_to :index
            
          end
					

        else

          unless current_usuario.perfil_actual
						
            perfil = Perfil.where("usuario_id = ?", current_usuario.id).first
            current_usuario.perfil_actual_id = perfil.id
            current_usuario.save
            

          end
          
          
          flash[:notice] = "Usuario autenticado exitosamente!!"
          
          if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_estudiante_superior]
            
            redirect_to :matriculaciones_superior_index
            
          else
                        
            redirect_to :index

          end
                     
					
					
          #redirect_to root_path
					


=begin
          current_usuario_session.destroy
          @usuario_session = UsuarioSession.new
          flash[:error] = "El usuario no cuenta con el perfil seleccionado !!"
          render :new
=end
        end
      
      else
        
        @usuario_session = UsuarioSession.new
        flash[:error] = "Verifique su usuario y password !!"
        render :new
      
      end

    else
      
      @usuario_session = UsuarioSession.new
      flash[:error] = "La persona no existe."
      render :new
 
    end
  
  end

  def destroy
    current_usuario_session.destroy
    flash[:notice] = "Desconectado exitosamente!"
    redirect_to :login
  end

  def acceso_denegado
    
    @msg = "No tiene acceso a esta Operación"

    respond_to do |f|

      f.js
      f.html

    end

  end


end
