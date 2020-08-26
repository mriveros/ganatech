class VAltaProduccion < ActiveRecord::Base

  self.table_name="v_altas_producciones"
  self.primary_key="alta_produccion_id"
  
  attr_accessible :alta_produccion_id, :ganado_id, :periodo, :ganado_nombre,
  :ganado_rp, :ganado_rfid, :created_at, :updated_at
  
  scope :orden_01, -> { order("alta_produccion_id")}
  
end