class AltaProduccionQueso < ActiveRecord::Base

  self.table_name="altas_producciones_quesos"
  self.primary_key="id"
  
  attr_accessible :id, :descripcion, :fecha_produccion, :periodo, :cantidad_obtenida, :peso_total, :cantidad_utilizado, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end