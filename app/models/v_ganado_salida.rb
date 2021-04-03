class VGanadoSalida < ActiveRecord::Base

  self.table_name="v_ganados_salidas"
  self.primary_key="ganado_salida_id"
  
  attr_accessible :ganado_salida_id, :peso_promedio, :ganado_id, :tipo_salida_id, :fecha_salida, :precio_venta, :observacion, :estado_movimiento_id,
  :cliente_id, :codigo_lote, :created_at, :updated_at
  
  scope :orden_01, -> { order("ganado_salida_id")}
  scope :fecha_salida, -> { order("fecha_salida desc")}
  
end