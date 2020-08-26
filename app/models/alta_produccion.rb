class AltaProduccion < ActiveRecord::Base

  self.table_name="altas_producciones"
  self.primary_key="id"
  
  attr_accessible :id, :ganado_id, :periodo, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end