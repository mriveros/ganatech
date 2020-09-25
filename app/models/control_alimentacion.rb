class ControlAlimentacion < ActiveRecord::Base

  self.table_name="controles_alimentaciones"
  self.primary_key="id"
  
  attr_accessible :id, :fecha_control , :ganado_id, :tipo_alimentacion_id, :alimentacion_id, :cantidad_suministrada, :observacion, :created_at, :updated_at, :codigo_lote
  
  scope :orden_01, -> { order("id")}
  
end