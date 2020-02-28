class UsuariosController < ApplicationController

	before_filter :require_usuario, :except => [:buscar_persona]

  def index
  end

  def lista

    cond = []
    args = []
      
    if params[:form_buscar_usuarios_id].present?

      cond << "usuarios.id = ?"
      args << params[:form_buscar_usuarios_id]
    
    end

    if params[:form_buscar_usuarios_nacionalidad_id].present?

      cond << "personas.nacionalidad_id = ?"
      args << params[:form_buscar_usuarios_nacionalidad_id]
    
    end

    if params[:form_buscar_usuarios_tipo_documento_id].present?

      cond << "personas.tipo_documento_id = ?"
      args << params[:form_buscar_usuarios_tipo_documento_id]
    
    end

    if params[:form_buscar_usuarios_documento_persona].present?

      cond << "personas.documento_persona = ?"
      args << params[:form_buscar_usuarios_documento_persona]
    
    end

    if params[:form_buscar_usuarios_nombre_persona].present?

      cond << "personas.nombre_persona ilike ?"
      args << "%#{params[:form_buscar_usuarios_nombre_persona]}%"

    end

    if params[:form_buscar_usuarios_apellido_persona].present?

      cond << "personas.apellido_persona ilike ?"
      args << "%#{params[:form_buscar_usuarios_apellido_persona]}%"

    end

    if params[:form_buscar_usuarios_email].present?

      cond << "usuarios.email ilike ?"
      args << "%#{params[:form_buscar_usuarios_email]}%"

    end

    if params[:form_buscar_usuarios] && params[:form_buscar_usuarios][:active].present?

      cond << "active = ?"
      args << params[:form_buscar_usuarios][:active]

    end
    
    cond = cond.join(" and ").lines.to_a + args if cond.size > 0
   
    if cond.size > 0

      @usuarios =  Usuario.joins(:persona).ordenado_id.where(cond).paginate(per_page: 10, page: params[:page])  
      @total_encontrados = Usuario.joins(:persona).where(cond).count     
      
    else
    
      @usuarios = Usuario.joins(:persona).ordenado_id.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Usuario.joins(:persona).count

    end

    @total_registros = Usuario.joins(:persona).count

    respond_to do |f|

      f.js

    end 

  end

  def agregar

    @usuario = Usuario.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""

    @usuario = Usuario.new(params[:usuario])
    @usuario.active = true

    persona = Persona.where("documento_persona = ? and tipo_documento_id = ? and nacionalidad_id = ?", params[:persona_documento], params[:persona][:tipo_documento_id], params[:persona][:nacionalidad_id])

    if persona.present?
      
      persona = persona.first

      edad = (DateTime.now - persona.fecha_nacimiento) / 365.25

      if edad.to_i < 18

        valido = false
        @msg += "Para acceder a una cuenta deber ser mayor edad.<br />"

      end

      if valido

        usuario_existente = Usuario.where("persona_id = ?", persona.id )

        unless usuario_existente.present?

          @usuario.persona_id = persona.id
          @usuario.login = "#{persona.documento_persona}-#{quita_acentos(persona.tipo_documento.descripcion.downcase[0..2])}-#{quita_acentos(persona.nacionalidad.descripcion.downcase[0..2])}"
      
        else

          valido = false
          @msg += "Este usuario ya ha sido registrado.<br />"

        end

      end

    else

      valido = false
      @msg += "Persona no encontrada."

    end
        
    if !params[:usuario][:email].present?

      @msg += "El campo correo electronico no puede quedar vacio.<br />"
      valido = false

    else

      if params[:usuario][:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

        @usuario.email = params[:usuario][:email]

      else

        valido = false
        @msg += "Formato de correo electronico no valido.<br />"

      end

    end

    if !params[:usuario][:password].present?
      
      valido = false
      @msg += "El campo de la contraseña no puede quedar vacio.<br />"
    
    end

    if !params[:usuario][:password_confirmation].present?
      
      valido = false
      @msg += "El campo de la confirmación de la contraseña no puede quedar vacio.<br />"
    
    end

    if params[:usuario][:password] != params[:usuario][:password_confirmation]
      
      valido = false
      @msg += "Las contraseñas no coinciden.<br />"
    
    end

    if !params[:agregar_usuario][:rol_id].present?
      
      valido = false
      @msg += "Seleccione un rol.<br />"
    
    end

    if valido
      
      if @usuario.save

        perfil = Perfil.new
        perfil.usuario_id = @usuario.id
        perfil.rol_id = params[:agregar_usuario][:rol_id]
        
        if perfil.save

          NotificarUsuario.email_usuario(@usuario, params[:usuario][:password]).deliver if params[:notificar_usuario]
          @usuario_ok = true

        end 
      
      else
        
        @msg = "ERROR: No se ha podido registrar el usuario."
      
      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @usuario = Usuario.find(params[:id])
    
    perfiles = Perfil.where("usuario_id = ?", @usuario.id)

    if perfiles.present?

      valido = false
      @msg = "Imposible eliminar... tiene perfiles relacionados.<br />"

    end

    if valido

      if @usuario.destroy
      
        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el usuario."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def editar

    @usuario = Usuario.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @usuario = Usuario.find(params[:usuario][:id])

    if !params[:usuario][:email].present?

      @msg += "El campo correo electronico no puede quedar vacio.<br />"
      valido = false

    else

      if params[:usuario][:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

        @usuario.email = params[:usuario][:email]

      else

        valido = false
        @msg += "Formato de correo electronico no valido.<br />"

      end

    end

    if valido

      @usuario.update_attributes(params[:usuario])

      if @usuario.save

        @usuario_ok = true

      else

        @msg = "ERROR: No se ha podido actualizar el usuario."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def reset_password

    @usuario = Usuario.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar_password

    valido = true
    @msg = ""

    @usuario = Usuario.find(params[:usuario][:id])

    if !params[:usuario][:password].present?
      
      valido = false
      @msg += "El campo de la contraseña no puede quedar vacio.<br />"
    
    end

    if !params[:usuario][:password_confirmation].present?
      
      valido = false
      @msg += "El campo de la confirmación de la contraseña no puede quedar vacio.<br />"
    
    end

    if params[:usuario][:password] != params[:usuario][:password_confirmation]
      
      valido = false
      @msg += "Las contraseñas no coinciden.<br />"
    
    end

    if valido

      @usuario.update_attributes(params[:usuario])

      if @usuario.save

        @usuario_ok = true

      else

        @msg = "ERROR: No se ha podido actualizar el usuario."

      end

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

  def perfiles

    @perfiles = Perfil.joins(:rol).where("usuario_id = ?", params[:usuario_id]).order("roles.descripcion")

    respond_to do |f|

      f.js

    end
  
  end

  def agregar_perfil

    perfiles = Perfil.where('usuario_id = ?', params[:usuario_id])
    v_roles = perfiles.present? ? perfiles.map(&:rol_id) : [0]

    cond = ["id not in (?)"]
    args = [v_roles]

    if params[:form_buscar_roles_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{quita_acentos(params[:form_buscar_roles_descripcion])}%"

    end

    cond = cond.join(" and ").lines.to_a + args 
    @roles = Rol.ordenado_descripcion.where(cond).paginate(page: params[:page], per_page: 7)

    respond_to do |f|
      f.js
    end

  end

  def guardar_perfil

    @valido = true
    @msg = ""

    @perfil = Perfil.new

    unless params[:usuario_id].present?

      @valido = false
      @msg += "El id del usuario no puede quedar vacio.<br />"

    end

    unless params[:rol_id].present?

      @valido = false
      @msg += "El id del rol no puede quedar vacio.<br />"

    end

    if @valido

      @perfil.rol_id = params[:rol_id]
      @perfil.usuario_id = params[:usuario_id]

      if @perfil.save

        @perfil_ok = true

      else

        @msg = "ERROR: No se ha podido registrar el perfil."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_perfil

    @perfil = Perfil.find(params[:id])
    @usuario_id = @perfil.usuario_id

    if @perfil.destroy

      @eliminado = true

    end

    respond_to do |f|

      f.js

    end

  end

  def mi_cuenta

    @persona = current_usuario.persona

  end

  def actualizar_mi_cuenta

    valido = true
    @msg = ""

    @usuario = current_usuario
    persona = current_usuario.persona

    persona.jurisdiccion_id = params[:persona_jurisdiccion][:id] if params[:persona_jurisdiccion] && params[:persona_jurisdiccion][:id].present?
    persona.direccion = params[:persona_direccion]
    persona.telefono = params[:persona_telefono]
    persona.celular = params[:persona_celular]

    if !params[:usuario][:email].present?

      @msg += "El campo correo electronico no puede quedar vacio.<br />"
      valido = false

    else

      if params[:usuario][:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

        @usuario.email = params[:usuario][:email]

      else

        valido = false
        @msg += "Formato de correo electronico no valido.<br />"

      end

    end

    if valido

      @usuario.update_attributes(params[:usuario])

      if @usuario.save

        if persona.save

          @usuario_ok = true

        end

      else

        @msg = "ERROR: No se ha podido actualizar su cuenta."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def actualizar_mi_password

    @msg = ""
    valido = true

    @usuario = current_usuario

    @usuario_session = UsuarioSession.new(params[:usuario_session])
    persona = current_usuario.persona
    @usuario_session.login = "#{persona.documento_persona}-#{quita_acentos(persona.tipo_documento.descripcion.downcase[0..2])}-#{quita_acentos(persona.nacionalidad.descripcion.downcase[0..2])}"
 
    if !@usuario_session.save

      @msg = "La contrase&ntilde;a anterior no coincide.<br />".html_safe
      valido = false;

    end

    if !params[:usuario][:password_confirmation].present?
      
      valido = false
      @msg += "El campo de la confirmación de la contraseña no puede quedar vacio.<br />"
    
    end

    if params[:usuario][:password] != params[:usuario][:password_confirmation]
      
      valido = false
      @msg += "Las contraseñas no coinciden.<br />"
    
    end

    if valido

      if params[:usuario][:password].size < 5

        @msg += "La contraseña debe tener como mínimo 5 caracteres.<br />"
        valido = false

      end

    end

    if valido

      if @usuario.update_attributes(params[:usuario])
        
        @usuario_ok = true

      else

        @msg = "ERROR: No se ha podido cambiar la contraseña."
 
      end
    
    end

    respond_to do |f|

      f.js

    end

  end

  def cambiar_perfil_actual

    current_usuario.perfil_actual_id = params[:perfil_id]
    current_usuario.save
    
    respond_to do |f|

      f.js 

    end

  end

end
