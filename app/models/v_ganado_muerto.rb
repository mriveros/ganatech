class VGanadoMuerto < ActiveRecord::Base

  self.table_name="v_ganados_muertos"
  self.primary_key="ganado_muerto_id"
  
  attr_accessible :ganado_muerto_id, :ganado_id, :motivo_muerte_id, :motivo_muerte,
   :fecha, :observacion, :documento_ganatec_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("ganado_muerto_id")}
  scope :orden_fecha, -> { order("fecha desc")}
  
end