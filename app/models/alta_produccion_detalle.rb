class AltaProduccionDetalle < ActiveRecord::Base

  self.table_name="altas_producciones_detalles"
  self.primary_key="id"
  
  attr_accessible :id, :alta_produccion_id, :desde_fecha, :hasta_fecha :cantidad_litros, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end