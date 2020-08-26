class VGanadoEnfermo < ActiveRecord::Base

  self.table_name="v_ganados_enfermos"
  self.primary_key="ganado_enfermo_id"
  
  attr_accessible :ganado_enfermo_id, :fecha, :ganado_id, :ganado_nombre, :ganado_rp, :enfermedad_id, 
  :enfermedad, :estado_enfermedad_id, :estado_enfermedad, :observacion,:created_at, :updated_at, :documento_ganatec_id
  
  scope :orden_01, -> { order("ganado_enfermo_id")}
  scope :orden_fecha, -> { order("fecha desc")}
  
end