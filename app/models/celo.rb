class Celo < ActiveRecord::Base

  self.table_name="celos"
  self.primary_key="id"
  
  attr_accessible :id, :ganado_id, :descripcion, :observacion, :fecha_inicio, :estado_celo_id,
  :fecha_fin, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end