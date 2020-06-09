class Esperma < ActiveRecord::Base

  self.table_name="espermas"
  self.primary_key="id"
  
  attr_accessible :id, :descripcion, :ganado_id, :numero_pajuela, :raza_id, :observacion,
  :estado_esperma_id, :esperma_procedencia_id, :costo_esperma, :fecha_registro, 
  :costo_total, :cantidad, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end