class VCelo < ActiveRecord::Base

  self.table_name="v_celos"
  self.primary_key="celo_id"
  
  attr_accessible :celo_id, :ganado_rfid, :ganado_nombre, :ganado_rp,
  :fecha_inicio, :fecha_fin, :descripcion, :hacienda_id, :hacienda, 
  :estado_celo_id, :estado_celo, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("celo_id")}
  
end