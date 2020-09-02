class VAltaProduccionQuesoDetalle < ActiveRecord::Base

  self.table_name="v_altas_producciones_quesos_detalles"
  self.primary_key="id"
  
  attr_accessible :alta_produccion_queso_detalle_id, :alta_produccion_id, :alta_produccion_detalle_id,
  :fecha_produccion, :desde_fecha, :hasta_fecha, :cantidad_litros, :estado_alta_produccion_detalle_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("alta_produccion_queso_detalle_id")}
  scope :orden_fecha_creacion, -> { order("created_at desc")}
  
end