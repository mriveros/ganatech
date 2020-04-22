module PacientesHelper

  def link_to_editar_paciente(persona_id)

      render partial: 'link_to_editar_paciente', locals: { persona_id: persona_id }
      
  end

  def link_to_paciente_detalle_fono(paciente_id)

    render partial: 'link_to_paciente_detalle_fono', locals: { paciente_id: paciente_id}

  end

  def verificar_sindrome(paciente_id)

    @paciente_detalle_fono = PacienteDetalleFono.where("paciente_id = ?", paciente_id).first
    if @paciente_detalle_fono.present?
    
      return (@paciente_detalle_fono.sindrome.present?)? true : false

    end

  end

  def verificar_transtorno(paciente_id)

    @paciente_detalle_fono = PacienteDetalleFono.where("paciente_id = ?", paciente_id).first
    if @paciente_detalle_fono.present?

      return (@paciente_detalle_fono.transtornos.present?)? true : false
    
    end

  end

  def verificar_enfermedad(paciente_id)

    @paciente_detalle_fono = PacienteDetalleFono.where("paciente_id = ?", paciente_id).first
    if @paciente_detalle_fono.present?

      return (@paciente_detalle_fono.enfermedad.present?)? true : false
    
    end

  end

  def break_the_lines(text)
    
    text.to_s.gsub(/\n/, '<br/>').html_safe

  end

  
  
end
