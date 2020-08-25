class GanadoEnfermo < ActiveRecord::Base

  self.table_name="ganados_enfermos"
  self.primary_key="id"
  
  attr_accessible :id, :ganado_id, :enfermedad_id, :fecha, :observacion, :created_at,  :updated_at, :documento_ganatec_id
  
  scope :orden_01, -> { order("id")}
  
end