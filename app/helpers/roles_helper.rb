module RolesHelper

  def link_to_editar_rol(rol)
    
    render :partial => 'link_to_editar_rol', :locals => { :rol => rol}

  end

  def link_to_accesos(rol)

    render partial: "link_to_accesos", locals: { rol: rol}

  end

  def es_administrador?

    administrador = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_administrador])
    administrador.present?

  end

  def es_administrador_eeb?
    administrador_eeb = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_nivel_eeb_administrador])
    administrador_eeb.present?
  end
  
  def es_director?

    director = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_director])
    director.present?

  end

  def es_informes_autorizacion_alimenticia?

    acceso = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_informes_autorizacion_alimenticia])
    acceso.present?

  end

  def es_infraestructura_fiscalizacion?

    acceso = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_infraestructura_fiscalizador])
    acceso.present?

  end

  def es_tecnico_becas_media?

    director = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_tecnico_administrativo])
    director.present?

  end
  
  def es_tecnico_administrativo?

    tecnico_administrativo = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_tecnico_becas_medias])
    tecnico_administrativo.present?

  end

  def es_tecnico_certificacion_academica?

    acceso = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_tecnico_certificacion_academica])
    acceso.present?

  end

  def es_consulta_general?

    administrador = VAcceso.where("usuario_id = ? and rol_id = ?", current_usuario.id, PARAMETRO[:rol_consulta_general])
    administrador.present?

  end

end