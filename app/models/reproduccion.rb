class Reproduccion < ActiveRecord::Base

  self.table_name="reproducciones"
  self.primary_key="id"
  
  attr_accessible :id, :celo_id, :esperma_id, :descripcion, :observacion, :estado_reproduccion_id,
  :fecha_reproduccion, :fecha_concepcion, :tipo_reproduccion_id, :ganado_reproductor_id,
  :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end