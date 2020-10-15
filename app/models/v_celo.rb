class VCelo < ActiveRecord::Base

  self.table_name="v_celos"
  self.primary_key="celo_id"
  
  attr_accessible :celo_id, :ganado_id, :codigo_rfid, :ganado_nombre, :ganado_rp,
  :fecha_inicio, :fecha_fin, :descripcion, :potrero_id, :potrero,:hacienda_id, :hacienda, 
  :estado_celo_id, :estado_celo, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("celo_id")}
  scope :orden_estado_celo, -> { order("estado_celo_id")}
  
end