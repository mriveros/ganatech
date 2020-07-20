class GanadoSalida < ActiveRecord::Base

  self.table_name="ganados_salidas"
  self.primary_key="id"
  
  attr_accessible :id, :peso_promedio, :ganado_id, :tipo_salida_id, :fecha_salida, :precio_venta, :observacion, :estado_movimiento_id,
  :cliente_id, :codigo_lote, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end