class TutorDetalle < ActiveRecord::Base

  self.table_name="tutores_detalles"
  self.primary_key="id"
  
  attr_accessible :id, :tutor_id, :paciente_id, :parentezco_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end