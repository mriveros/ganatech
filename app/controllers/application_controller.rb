class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_usuario_session, :current_usuario, :quita_acentos, :rol_tutor, :rol_docente, :rol_director, :rol_supervisor, :rol_administrador,:rol_tecnico_becas_medias
  protect_from_forgery with: :exception

  def formatear_fecha(fecha)

    fecha.length > 0 ? fecha[6..9]+"-"+fecha[3..4]+"-"+fecha[0..1] : nil

  end

  def quita_acentos( cadena )
    cadena = cadena.gsub(/[áàâãäÁÀÂÃÄ]/, 'a').downcase
    cadena = cadena.gsub(/[éèêẽëÉÈÊẼË]/, 'e').downcase
    cadena = cadena.gsub(/[íìîĩïÍÌÎĨÏ]/, "i").downcase
    cadena = cadena.gsub(/[óòôõöÓÒÔÕÖ]/, "o").downcase
    cadena = cadena.gsub(/[úùûũüÚÙÛŨÜ]/, "u").downcase
    cadena = cadena.gsub(/[ýỳŷỹÿÝỲŶỸŸ]/, "y").downcase
    return cadena
  end

  def traducir_dia( cadena )
    cadena = cadena.gsub('Sunday', 'Domingo')
    cadena = cadena.gsub('Monday', 'Lunes')
    cadena = cadena.gsub('Tuesday', 'Martes')
    cadena = cadena.gsub('Wednesday', 'Miércoles')
    cadena = cadena.gsub('Thursday', 'Jueves')
    cadena = cadena.gsub('Friday', 'Viernes')
    cadena = cadena.gsub('Saturday', 'Sábado')
    return cadena
  end

  def is_number? string
    true if Float(string) rescue false
  end  

  def autocompletar
      
    html = ""
    
    if params[:term].present?
      
      params[:term] = quita_acentos(params[:term])
      
      hashes = {}
      if params[:model] == 'PersonaFull'
     
        hashes[:conditions] = ["#{( params[:cadena_consulta].present? ? params[:cadena_consulta] : params[:atributo_id] ) } = ?", "#{params[:term].upcase}"]

      elsif params[:model] == 'VNomina'
        if params[:atributo_tipo] == 'int'
          hashes[:conditions] = ["#{( params[:cadena_consulta_adicional] ) } and CAST(#{ params[:cadena_consulta] } AS TEXT) like ?", "%#{params[:term].upcase}%"]
        else
          hashes[:conditions] = ["#{( params[:cadena_consulta_adicional] ) } and #{( params[:cadena_consulta].present? ? params[:cadena_consulta] : params[:atributo_id] ) } like ?", "%#{params[:term].upcase}%"]
        end
      else
        if params[:atributo_tipo] == 'int'
          hashes[:conditions] = ["CAST(#{ params[:cadena_consulta] } AS TEXT) like ?", "%#{params[:term].upcase}%"]
        else
          hashes[:conditions] = ["#{( params[:cadena_consulta].present? ? params[:cadena_consulta] : params[:atributo_id] ) } like ?", "%#{params[:term].upcase}%"]
        end
     
      end
      
      hashes[:order] = params[:orden] if params[:orden].present?
      hashes[:limit] = params[:limit].to_i if params[:limit].present?
      
      resultados = params[:model].constantize.where(hashes[:conditions]).order(hashes[:order]).uniq.pluck(params[:atributo_id], params[:atributo_descripcion]).take(hashes[:limit])

      if resultados.present?
        
        resultados.each do |objeto|

          html += "{\"id\":\"#{eval("objeto[0]")}\","
          html += "\"label\":\"#{eval("objeto[1]")}\","
          html += "\"value\":\"#{eval("objeto[1]")}\"},"

        end
        
      end

    end

    respond_to do |f|

      f.html { render :text => "[#{html[0..html.size-2]}]".html_safe }

    end

  end

  def rol_tutor
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_tutor])
    perfil.present?
  end

  def rol_docente
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_docente])
    perfil.present?
  end

  def rol_director
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_director])
    perfil.present?
  end

  def rol_supervisor
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_supervisor])
    perfil.present?
  end
  
  def rol_coordinador
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_coordinador])
    perfil.present?
  end

  def rol_administrador
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_administrador])
    perfil.present?
  end

  def rol_tecnico_becas_medias
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_tecnico_becas_medias])
    perfil.present?
  end
  def rol_administrador_becas_media
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_administrador_becas_media])
    perfil.present?
  end

  def rol_administrador_biblioteca
    perfil = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_administrador_biblioteca])
    perfil.present?
  end


  private
    
  def current_usuario_session
    return @current_usuario_session if defined?(@current_usuario_session)
    @current_usuario_session = UsuarioSession.find
  end

  def current_usuario
    return @current_usuario if defined?(@current_usuario)
    @current_usuario = current_usuario_session && current_usuario_session.usuario
  end

  def require_usuario
    logger.debug "ApplicationController::require_usuario"
    if current_usuario
      control_acceso
    else
      redirect_to :login
    end
  end

  def store_location
    #session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  #CONTROL DE ACCESOS
  def control_acceso

    no_verificar = ['usuarios_sessions']

    unless no_verificar.include?(controller_name)

      permitido = VAcceso.where("usuario_id = ? and controlador = ? and accion = ? and sistema_id = ?", current_usuario.id, controller_name, action_name, VAcceso::SISTEMA_ID)

      unless permitido.present?

        redirect_to usuarios_sessions_acceso_denegado_path

      end

    end

  end
  #FIN CONTROL DE ACCESOS
 
   #AUDITORIAS
  def auditoria_antes(accion, tabla, objeto)
    auditoria = Auditoria.new
    auditoria.usuario = current_usuario.login
    auditoria.ip = request.remote_ip
    auditoria.accion = accion
    auditoria.tabla = tabla
    auditoria.pista_antes = objeto.to_json
    auditoria.sistema = "Ganatec"
    auditoria.save

    auditoria.id

  end

  def auditoria_despues(objeto, auditoria_id)
    auditoria = Auditoria.find(auditoria_id)
    auditoria.pista_despues = objeto.to_json
    auditoria.usuario_update = current_usuario.login
    auditoria.ip_update = request.remote_ip
    auditoria.save
  end

  def auditoria_nueva(accion, tabla, objeto)
    Auditoria.create(usuario: current_usuario.login, ip: request.remote_ip, accion: accion, tabla: tabla, pista_despues: objeto.to_json, sistema: "Ultron" )
  end  
  #FIN AUDITORIAS 


 #VALIDA FORMATO DE CORREO ELECTRONICO
  def es_correo_valido? (correoE)
    (correoE =~ /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z])+$/)==0
  end
  
end
