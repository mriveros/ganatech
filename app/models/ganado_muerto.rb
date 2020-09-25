class GanadoMuerto < ActiveRecord::Base

  self.table_name="ganados_muertos"
  self.primary_key="id"
  
  attr_accessible :id, :ganado_id, :motivo_muerte_id, :fecha, :observacion, :documento_ganatec_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
  
  
end