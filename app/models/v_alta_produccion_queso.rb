class VAltaProduccionQueso < ActiveRecord::Base

  self.table_name="v_altas_producciones_quesos"
  self.primary_key="alta_produccion_queso_id"
  
  attr_accessible :alta_produccion_queso_id, :fecha_produccion, 
  :periodo, :cantidad_obtenida, :peso_total, :cantidad_utilizado, 
  :estado_alta_produccion_queso, :estado_alta_produccion_queso_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("alta_produccion_queso_id")}
  
end