class VAltaProduccionDetalle < ActiveRecord::Base

  self.table_name="v_altas_producciones_detalles"
  self.primary_key="alta_produccion_detalle_id"
  
  attr_accessible :alta_produccion_detalle_id,:ganado_id, :periodo, :alta_produccion_id, :ganado_nombre, :ganado_rp,
  :ganado_rfid,  :desde_fecha, :hasta_fecha, :cantidad_litros, :created_at, :updated_at, :estado_alta_produccion_detalle,
  :estado_alta_produccion_detalle_id
  
  scope :orden_01, -> { order("alta_produccion_detalle_id")}
  scope :orden_fecha_creacion, -> { order("created_at desc")}
  
end