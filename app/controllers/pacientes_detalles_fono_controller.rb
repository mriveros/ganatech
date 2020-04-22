class PacientesDetallesFonoController < ApplicationController

before_filter :require_usuario
skip_before_action :verify_authenticity_token

  def index
  

  end

  def paciente_detalle_fono

    @paciente = Paciente.where("id = ?", params[:paciente_id]).first
    @paciente_detalle_fono = PacienteDetalleFono.where("paciente_id = ?", params[:paciente_id]).first

    respond_to do |f|

      f.js

    end
    
  end


  def guardar_detalle_fono

    @valido = true
    guardado_ok = false

    @paciente = Paciente.where("id = ?", params[:paciente_id]).first

    @paciente_detalle_fono = PacienteDetalleFono.where("paciente_id = ?", params[:paciente_id]).first

    if @paciente_detalle_fono.present?

     auditoria_id = auditoria_antes("actualizar datos de detalles de pacientes", "pacientes_detalles_fono", @paciente_detalle_fono)
      @paciente_detalle_fono.antecedentes_personales = params[:antecedentes_personales].gsub("\r\n", '<br/>')
      @paciente_detalle_fono.antecedentes_familiares = params[:antecedentes_familiares].gsub("\r\n", '<br/>')
      @paciente_detalle_fono.antecedentes_otros = params[:antecedentes_otros].gsub("\r\n", '<br/>')
      @paciente_detalle_fono.antecedentes_habitos = params[:antecedentes_habitos].gsub("\r\n", '<br/>')
      @paciente_detalle_fono.sindrome = params[:sindrome]
      @paciente_detalle_fono.sindrome_especificar = params[:sindrome_especificar]
      @paciente_detalle_fono.transtornos = params[:transtornos]
      @paciente_detalle_fono.transtorno_especificar = params[:transtorno_especificar]
      @paciente_detalle_fono.enfermedad = params[:enfermedad]
      @paciente_detalle_fono.enfermedad_especificar = params[:enfermedad_especificar]
      @paciente_detalle_fono.escolaridad_grado_id = params[:escolaridad_grado][:id]
      @paciente_detalle_fono.escolaridad_tiempo = params[:escolaridad_tiempo]
      @paciente_detalle_fono.escolaridad_institucion = params[:escolaridad_institucion]
      @paciente_detalle_fono.datos_derivacion = params[:datos_derivacion]
      
      if @paciente_detalle_fono.save

        @guardado_ok = true
       auditoria_despues(@paciente_detalle_fono, auditoria_id)

      end

    else

      @paciente_detalle_fono = PacienteDetalleFono.new
      @paciente_detalle_fono.paciente_id = params[:paciente_id]
      @paciente_detalle_fono.antecedentes_personales = params[:antecedentes_personales]
      @paciente_detalle_fono.antecedentes_familiares = params[:antecedentes_familiares]
      @paciente_detalle_fono.antecedentes_otros = params[:antecedentes_otros]
      @paciente_detalle_fono.antecedentes_habitos = params[:antecedentes_habitos]
      @paciente_detalle_fono.sindrome = params[:sindrome]
      @paciente_detalle_fono.sindrome_especificar = params[:sindrome_especificar]
      @paciente_detalle_fono.transtornos = params[:transtornos]
      @paciente_detalle_fono.transtorno_especificar = params[:transtorno_especificar]
      @paciente_detalle_fono.enfermedad = params[:enfermedad]
      @paciente_detalle_fono.enfermedad_especificar = params[:enfermedad_especificar]
      @paciente_detalle_fono.escolaridad_grado_id = params[:escolaridad_grado][:id]
      @paciente_detalle_fono.escolaridad_tiempo = params[:escolaridad_tiempo]
      @paciente_detalle_fono.escolaridad_institucion = params[:escolaridad_institucion]
      @paciente_detalle_fono.datos_derivacion = params[:datos_derivacion]
      
      if @paciente_detalle_fono.save

        @guardado_ok = true
        auditoria_nueva("registrar paciente detalle fono", "pacientes_detalles_fono", @paciente_detalle_fono)

      end

    end

    respond_to do |f|

      f.js

    end
    
  end

end