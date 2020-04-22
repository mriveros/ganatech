class PacienteDetalleFono < ActiveRecord::Base

  self.table_name="pacientes_detalles_fono"
  self.primary_key="id"
  
  attr_accessible :id, :paciente_id, :antecedentes_personales, :antecedentes_familiares, :antecedentes_otros, :antecedentes_habitos, :sindrome,
  :sindrome_especificar, :transtornos, :transtorno_especificar, :enfermedad, :enfermedad_especificar, 
  :escolaridad_grado_id, :escolaridad_tiempo, :escolaridad_institucion, :datos_derivacion
  
  scope :orden_01, -> { order("id")}
  
end