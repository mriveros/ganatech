class AltaProduccionQuesoDetalle < ActiveRecord::Base

  self.table_name="altas_producciones_quesos_detalles"
  self.primary_key="id"
  
  attr_accessible :id, :alta_produccion_queso_id, :alta_produccion_detalle_id ,:created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end