# -*- encoding : utf-8 -*-
class PrincipalController < ApplicationController
   

  def index

    mes_actual = Time.now.month
    anho_actual = Time.now.year

    @producciones_total = VProduccion.all

    @producciones_cobrados = VProduccion.where("EXTRACT (MONTH FROM fecha_produccion) = ? and EXTRACT (YEAR FROM fecha_produccion) = ? and cobrado = ?", mes_actual, anho_actual,  true)
    @producciones_sin_cobrar = VProduccion.where("EXTRACT (MONTH FROM fecha_produccion) = ? and EXTRACT (YEAR FROM fecha_produccion) = ? and cobrado = ?", mes_actual, anho_actual , false)
    @producciones_no_pertenece = VProduccion.where(" EXTRACT (MONTH FROM fecha_produccion) = ? and EXTRACT (YEAR FROM fecha_produccion) = ? and pertenece = ?", mes_actual, anho_actual, false)
    @producciones_pertenece = VProduccion.where("EXTRACT (MONTH FROM fecha_produccion) = ? and EXTRACT (YEAR FROM fecha_produccion) = ? and pertenece = ?", mes_actual, anho_actual, true)
    @cantidad_producciones = VProduccion.where("EXTRACT (MONTH FROM fecha_produccion) = ? and EXTRACT (YEAR FROM fecha_produccion) = ?", mes_actual, anho_actual)
    @gastos_producciones = VProduccionDetalleDebito.where("EXTRACT (MONTH FROM fecha) = ? and EXTRACT (YEAR FROM fecha) = ?", mes_actual, anho_actual)

    
    
  end
	
	def index_v2
		
		
		roles_ids = Perfil.where("usuario_id = ? ", current_usuario.id ).map(&:rol_id)
		@informacion_roles = InformacionRol.where("rol_id in (?) ", roles_ids)
		informaciones_ids = InformacionRol.where("rol_id in (?) ", roles_ids).map(&:informacion_id)
		informaciones_sin_roles_ids = Informacion.where("id not in (select distinct informacion_id from informaciones_roles) ").map(&:id)
		@informaciones = Informacion.where("id in (?) or id in (?)", informaciones_ids, informaciones_sin_roles_ids).order('fecha_publicacion DESC').paginate(per_page: 15, page: params[:page])
		@total_encontrados = Informacion.where("id in (?) or id in (?)", informaciones_ids, informaciones_sin_roles_ids).order('fecha_publicacion DESC').count
		
		
    if roles_ids.include?(PARAMETRO[:rol_nivel_inicial_administrador]) || roles_ids.include?( PARAMETRO[:rol_nivel_eeb_administrador] ) || roles_ids.include?(PARAMETRO[:rol_educacion_indigena_administrador]) || roles_ids.include?(PARAMETRO[:rol_permanente_administrador]) || roles_ids.include?(PARAMETRO[:rol_director])

      @calendario_examenes_escolar_inicial = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_inicial]).order('fecha_hasta ASC')
			@calendario_examenes_escolar_basica = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_basico]).order('fecha_hasta ASC')

    elsif roles_ids.include?(PARAMETRO[:rol_nivel_medio_cientifico_administrador]) || roles_ids.include?(PARAMETRO[:rol_tecnico_pedagogico_media]) || roles_ids.include?(PARAMETRO[:rol_nivel_medio_tecnico_administrador])

			@calendario_examenes_educacion_media = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_medio]).order('fecha_hasta ASC')
    
    elsif roles_ids.include?(PARAMETRO[:rol_nivel_superior_administrador]) 
										
      @calendario_examenes_educacion_superior = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_superior]).order('fecha_hasta ASC')
    
    end



		
  end

  def index_v3
    
    
		puts "ACCEDE A INDEX V2"
		roles_ids = Perfil.where("usuario_id = ? ", current_usuario.id ).map(&:rol_id)
		@informacion_roles = InformacionRol.where("rol_id in (?) ", roles_ids)
		informaciones_ids = InformacionRol.where("rol_id in (?) ", roles_ids).map(&:informacion_id)
		informaciones_sin_roles_ids = Informacion.where("id not in (select distinct informacion_id from informaciones_roles) ").map(&:id)
		@informaciones = Informacion.where("id in (?) or id in (?)", informaciones_ids, informaciones_sin_roles_ids).order('fecha_publicacion DESC').paginate(per_page: 15, page: params[:page])
		@total_encontrados = Informacion.where("id in (?) or id in (?)", informaciones_ids, informaciones_sin_roles_ids).order('fecha_publicacion DESC').count
		

    if roles_ids.include?(PARAMETRO[:rol_nivel_inicial_administrador]) || roles_ids.include?( PARAMETRO[:rol_nivel_eeb_administrador] ) || roles_ids.include?(PARAMETRO[:rol_educacion_indigena_administrador]) || roles_ids.include?(PARAMETRO[:rol_permanente_administrador]) || roles_ids.include?(PARAMETRO[:rol_director])

      @calendario_examenes_escolar_inicial = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_inicial]).order('fecha_hasta ASC')
			@calendario_examenes_escolar_basica = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_basico]).order('fecha_hasta ASC')

    elsif roles_ids.include?(PARAMETRO[:rol_nivel_medio_cientifico_administrador]) || roles_ids.include?(PARAMETRO[:rol_tecnico_pedagogico_media]) || roles_ids.include?(PARAMETRO[:rol_nivel_medio_tecnico_administrador])

			@calendario_examenes_educacion_media = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_medio]).order('fecha_hasta ASC')
    
    elsif roles_ids.include?(PARAMETRO[:rol_nivel_superior_administrador]) 
										
      @calendario_examenes_educacion_superior = VNotaNivel.where("nivel_educativo_id = ?", PARAMETRO[:nivel_educativo_superior]).order('fecha_hasta ASC')
    
    end

    

    if current_usuario.present? && current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_coordinador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_supervisor_pedagogico] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_supervisor]
            
      @valido = true
      @msg =""
      cond = []
      args = []
      
      if params[:codigo_institucion].present? 
                
        
        @institucion = VOfertaEducativa.where("v_ofertas_educativas.codigo_institucion = ?", params[:codigo_institucion]).first
       
        if @institucion.present?
          
          cond << "codigo_institucion = ?"
          args << params[:codigo_institucion]
          
        else
          
          @valido = false
          @msg = "No se encontro institución con este código."
          
        end
        
 
      end
      
      if @valido
    
        if params[:documento].present? 
        
          @persona_director = Persona.where("documento_persona = ?", params[:documento]).first
       
          if @persona_director.present?
            
            @usuario_director = Usuario.where("persona_id = ?", @persona_director.id).first

            if @usuario_director.present?
          
              @ofertas_director = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", @usuario_director.id, PARAMETRO[:rol_director])

              if @ofertas_director.present?
            
                v_matriculaciones_ids = []
       
                @ofertas_director.each do |uoe|

                  oferta_educativa_usuario = OfertaEducativa.where("id = ?", uoe.oferta_educativa_id).first

                  if uoe.turno_id.present?

                    matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and turno_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, uoe.turno_id, oferta_educativa_usuario.modalidad_nivel_id)

                  else

                    matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, oferta_educativa_usuario.modalidad_nivel_id)

                  end

                  if matriculaciones_usuarios.present?

                    matriculaciones_usuarios.each do |mu|

                      v_matriculaciones_ids << mu.matriculacion_id

                    end
                  
                    

                  end

                end
                
                cond << "matriculacion_id in (?)"
                args << v_matriculaciones_ids
              
              else
            
                @valido = false
                @msg += "No se encontraron instituciones asociadas al usuario.\n"
            
              end

            else
            
              @valido = false
              @msg += "No se encontro usuario con rol de director de la persona.\n"
            
            end
          
          else
          
            @valido = false
            @msg += "No se encontro persona con este documento.\n"
          
          end
 
        end
      
      
        if @valido
          
          
          # SI EL USUARIO ES UN SUPERVISOR PEDAGOGICO    
          if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_supervisor_pedagogico]
            puts "---- ES SUPERVISOR PEDAGOGICO ----"
            usuario_dependencia = UsuarioDependencia.where("usuario_id= ? and rol_id= ?",current_usuario.id,current_usuario.perfil_actual.rol_id)
            dependencias_ids = []
            usuario_dependencia.each_with_index{|d, i|
              dependencias_ids[i] = d.dependencia_id
            }
            puts dependencias_ids
            if dependencias_ids.size > 0
              cond << "supervision_pedagogica_id in (?) "
              args << dependencias_ids
            else
              cond << "2 = ?"
              args << "1"
            end

          end

          # SI EL USUARIO ES UN SUPERVISOR
          if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_supervisor]
            puts "---- ES SUPERVISOR  ----"
            usuario_dependencia = UsuarioDependencia.where("usuario_id= ? and rol_id= ?",current_usuario.id,current_usuario.perfil_actual.rol_id)
            dependencias_ids = []
            usuario_dependencia.each_with_index{|d, i|
              dependencias_ids[i] = d.dependencia_id
            }
            if dependencias_ids.size > 0
              cond << "supervision_administrativa_id in (?) "
              args << dependencias_ids
            else
              cond << "2 = ?"
              args << "1"
            end
      
          end
          
          #SI EL USUARIO ES UN COORDINADOR
          if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_coordinador]
            puts "---- ES COORDINADOR  ----"
            usuario_dependencia = UsuarioDependencia.where("usuario_id= ? and rol_id= ?",current_usuario.id,current_usuario.perfil_actual.rol_id)
            dependencias_ids = []
            usuario_dependencia.each_with_index{|d, i|
              dependencias_ids[i] = d.dependencia_id
            }
            if dependencias_ids.size > 0
              cond << "coordinacion_administrativa_id in (?) "
              args << dependencias_ids
            else
              cond << "2 = ?"
              args << "1"
            end
          end
          
          
          
          
          if cond.size > 0
            
            cond << "periodo = ?"
            args << params[:periodo]
            
            cond = cond.join(" and ").lines.to_a + args
            
            @estadisticas_cantidades = MvEstadisticaAcademicaMatriculacion.select("periodo, codigo_institucion, nombre_institucion, sum(cantidad_matriculados) as cantidad_matriculados, sum(cantidad_logrados_final) as cantidad_logrados_final, sum(cantidad_no_logrados_final) as cantidad_no_logrados_final, sum(cantidad_logrados_primer_parcial) as cantidad_logrados_primer_parcial, sum(cantidad_no_logrados_primer_parcial) as cantidad_no_logrados_primer_parcial, sum(cantidad_logrados_segundo_parcial) as cantidad_logrados_segundo_parcial, sum(cantidad_no_logrados_segundo_parcial) as cantidad_no_logrados_segundo_parcial").where(cond).group("periodo, codigo_institucion, nombre_institucion").order("codigo_institucion, nombre_institucion, periodo desc")

          end
          
        end
      
      end
      
    elsif current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_inicial_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_inicial_consulta] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_eeb_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_eeb_consulta] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_cientifico_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_cientifico_consulta] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_inclusiva_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_inclusiva_consulta] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_tecnico_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_tecnico_consulta] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_educacion_indigena_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_educacion_indigena_consulta] 

      cond = []
      args = []

      v_modalidades_niveles_ids = []
      cursos_nuevo_nivel_administrador_cientifico = []

      if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_inicial_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_inicial_consulta] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_eeb_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_eeb_consulta]

        v_modalidades_niveles_ids = PARAMETRO[:modalidades_educacion_inicial_eeb]

        if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_inicial_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_inicial_consulta] 

          cond << "v_matriculaciones_v3.curso_id in (?)"
          args << PARAMETRO[:cursos_inicial]

        end

        if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_eeb_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_eeb_consulta] 

          cond << "v_matriculaciones_v3.curso_id in (?)"
          args << PARAMETRO[:cursos_eeb] + PARAMETRO[:cursos_eeb_3erciclo] + PARAMETRO[:cursos_inicial]

        end

      end 


      if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_cientifico_consulta]

        v_modalidades_niveles_ids += PARAMETRO[:modalidades_educacion_media_cientifico]
        v_modalidades_niveles_ids += PARAMETRO[:modalidades_educacion_media_tecnico] #por la unificación del Nivel Medio se habilita la consulta de todas las modalidades
 

      end 

      # Si el Rol es Nivel Medio Cientifico administrador debe tambien ver nivel medio Cientifico, Nivel Medio Tecnico, y 3er ciclo(7mmo, 8vo, 9no)
      if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_cientifico_administrador] 

        cursos_nuevo_nivel_administrador_cientifico += PARAMETRO[:cursos_nuevo_nivel_administrador_cientifico]
        

      end 


      if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_tecnico_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_nivel_medio_tecnico_consulta]

        v_modalidades_niveles_ids += PARAMETRO[:modalidades_educacion_media_tecnico] 

      end 


      if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_inclusiva_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_inclusiva_consulta]

        v_modalidades_niveles_ids += PARAMETRO[:modalidades_educacion_inclusiva_formal] 
        v_modalidades_niveles_ids += PARAMETRO[:modalidades_educacion_inclusiva_noformal] 

      end

      if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_educacion_indigena_administrador] || current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_educacion_indigena_consulta]

        v_modalidades_niveles_ids += PARAMETRO[:modalidades_educacion_indigena] 

      end 

      if v_modalidades_niveles_ids.size > 0

        cond << "modalidad_nivel_id in (?)"
        args << v_modalidades_niveles_ids

      elsif cursos_nuevo_nivel_administrador_cientifico.size > 0
        cond << "curso_id in (?)"
        args << cursos_nuevo_nivel_administrador_cientifico
      
      else

        cond << "1 = ?"
        args << 2

      end
      
      if cond.size > 0
            
        cond << "periodo = ?"
        args << params[:periodo]
            
        cond = cond.join(" and ").lines.to_a + args
            
        @estadisticas_cantidades = MvEstadisticaAcademicaMatriculacion.select("periodo, codigo_institucion, nombre_institucion, sum(cantidad_matriculados) as cantidad_matriculados, sum(cantidad_logrados_final) as cantidad_logrados_final, sum(cantidad_no_logrados_final) as cantidad_no_logrados_final, sum(cantidad_logrados_primer_parcial) as cantidad_logrados_primer_parcial, sum(cantidad_no_logrados_primer_parcial) as cantidad_no_logrados_primer_parcial, sum(cantidad_logrados_segundo_parcial) as cantidad_logrados_segundo_parcial, sum(cantidad_no_logrados_segundo_parcial) as cantidad_no_logrados_segundo_parcial").where(cond).group("periodo, codigo_institucion, nombre_institucion").order("codigo_institucion, nombre_institucion, periodo desc")

      end

    elsif current_usuario.present? && current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_director]

      unless params[:periodo].present?

        params[:periodo] = 2018

      end

      usuarios_ofertas_educativas = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", current_usuario.id, PARAMETRO[:rol_director])

      if usuarios_ofertas_educativas.present?

        v_matriculaciones_ids = []
       
        usuarios_ofertas_educativas.each do |uoe|

          oferta_educativa_usuario = OfertaEducativa.where("id = ?", uoe.oferta_educativa_id).first

          if uoe.turno_id.present?

            matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and turno_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, uoe.turno_id, oferta_educativa_usuario.modalidad_nivel_id)

          else

            matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, oferta_educativa_usuario.modalidad_nivel_id)

          end

          if matriculaciones_usuarios.present?

            matriculaciones_usuarios.each do |mu|

              v_matriculaciones_ids << mu.matriculacion_id

            end

          end

        end

        if v_matriculaciones_ids.size > 0

          @estadisticas_cantidades = MvEstadisticaAcademicaMatriculacion.select("periodo, codigo_institucion, nombre_institucion, sum(cantidad_matriculados) as cantidad_matriculados, sum(cantidad_logrados_final) as cantidad_logrados_final, sum(cantidad_no_logrados_final) as cantidad_no_logrados_final, sum(cantidad_logrados_primer_parcial) as cantidad_logrados_primer_parcial, sum(cantidad_no_logrados_primer_parcial) as cantidad_no_logrados_primer_parcial, sum(cantidad_logrados_segundo_parcial) as cantidad_logrados_segundo_parcial, sum(cantidad_no_logrados_segundo_parcial) as cantidad_no_logrados_segundo_parcial").where("matriculacion_id in (?) and periodo = ?", v_matriculaciones_ids, params[:periodo]).group("periodo, codigo_institucion, nombre_institucion").order("codigo_institucion, nombre_institucion, periodo desc")

        end

      end
     

    end

  end

  def about

  end

  def legal

  end

  def contactos

  end

  def agregar_usuario


  end

  def guardar_usuario

    valido = true
    @msg = ""

    @usuario = Usuario.new

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
          password = Usuario.generar_password
          @usuario.password = password 
          @usuario.password_confirmation = password
          @usuario.active = false
          @usuario.token = Digest::MD5.hexdigest(Time.now.to_s)
      
        else

          valido = false
          @msg += "Este usuario ya ha sido registrado.<br />"

        end

      end

    else

      valido = false
      @msg += "Persona no encontrada.<br />ENVIE SU NRO DE DOCUMENTO Y CORREO ELECTRONICO AL CORREO soporte@mec.gov.py para realizar verificaciones."

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

    if params[:perfil] && params[:perfil][:rol_id].present?

      rol_id = params[:perfil][:rol_id]

    else

      @msg += "Seleccione un perfil.<br />"
      valido = false

    end

    #if !verify_recaptcha(:model => @usuario) 
    if !RecaptchaVerifier.verify(params["g-recaptcha-response"])
    
      @msg += "Código de verificación no valida.<br />Recargue el código verificador o presione F5."
      valido = false
    
    end

    if valido

      if @usuario.save

        perfil = Perfil.new
        perfil.usuario_id = @usuario.id
        perfil.rol_id = rol_id
        
        if perfil.save

          NotificarUsuario.email(@usuario, password).deliver
          @usuario_ok = true

        end 

      else

        @msg += "ERROR: No se ha podido registrar el usuario."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def activar_cuenta

    if params[:a].present?

      @usuario = Usuario.where('token = ?', params[:a]).first

      if @usuario.present?

        @usuario.active = true
        
        if @usuario.save

          @msg = "Cuenta activada exitosamente."
          @activado = true

        else

          @msg = "No se ha podido activar la cuenta."
          @activado = false

        end 

      else

        @msg = "No se ha encontrado la cuenta."
        @activado = false

      end

    else

      @msg = "El parámetro no existe."
      @activado = false

    end

    respond_to do |f|

      f.html

    end

  end

  def recuperar_password


  end

  def guardar_recuperar_password

    valido = true
    @msg = ""

    persona = Persona.joins("join usuarios u on personas.id = u.persona_id and active = true").where("documento_persona = ? and tipo_documento_id = ? and nacionalidad_id = ? and fecha_nacimiento = ?", params[:persona_documento], params[:persona][:tipo_documento_id], params[:persona][:nacionalidad_id], formatear_fecha(params[:fecha_nacimiento])).first

    if persona.present?
      
      @usuario = Usuario.where("persona_id = ?", persona.id ).first
      
      unless @usuario.present?

        valido = false
        @msg += "Usuario no encontrado o inactivo.<br />"

      end

      #if !verify_recaptcha(:model => @usuario)
      if !RecaptchaVerifier.verify(params["g-recaptcha-response"])
    
        @msg += "Código de verificación no valida.<br />Recargue el código verificador o presione F5."
        valido = false
    
      end

      if valido

        password = Usuario.generar_password
        @usuario.password = password 
        @usuario.password_confirmation = password
        @usuario.failed_login_count = 0

        if @usuario.save

          NotificarUsuario.email_recuperar_password(@usuario, password).deliver
          @usuario_ok = true

        end

      end

    else

      valido = false
      @msg += "Usuario no encontrado o inactivo."

    end

    respond_to do |f|

      f.js

    end

  end

  def buscar_usuario
    
    if params[:tipo_documento_id].present? && params[:nacionalidad_id] && params[:documento].present? && params[:fecha_nacimiento].present?

      @persona = Persona.joins("join usuarios u on personas.id = u.persona_id and u.active = true").where("tipo_documento_id = ? and nacionalidad_id = ? and documento_persona = ? and fecha_nacimiento = ?", params[:tipo_documento_id], params[:nacionalidad_id], params[:documento], formatear_fecha(params[:fecha_nacimiento])).first
 
    end

    respond_to do |f|
      f.json { render :json => @persona, :methods => :usuario_email}
    end

  end
  
  def buscar_institucion
    
    if params[:codigo_institucion].present?

      @institucion = VOfertaEducativa.where("v_ofertas_educativas.codigo_institucion = ?", params[:codigo_institucion]).first

    end
    
    respond_to do |f|
      
      f.json { render :json => @institucion }
    
    end
  
  end
  
  def buscar_persona
    
    if params[:documento].present? 

      @persona = Persona.where("documento_persona = ?",  params[:documento]).first
 
    end

    respond_to do |f|
      f.json { render :json => @persona}
    end

  end

end
