class VPaciente < ActiveRecord::Base

  self.table_name="v_pacientes"
  self.primary_key="paciente_id"
  
  attr_accessible :id_paciente, :documento_persona, :nombre_persona, :apellido_persona, :tipo_documento_id, :tipo_documento, :fecha_nacimiento, :nacionalidad_id, :nacionalidad,  :direccion, :telefono, :celular, :correo_electronico
 
  scope :orden_01, -> { order("paciente_id")}

  
end
