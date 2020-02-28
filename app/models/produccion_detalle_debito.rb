class ProduccionDetalleDebito < ActiveRecord::Base
  	
  	self.table_name="producciones_detalles_debitos"
	self.primary_key="id"
	
  attr_accessible :id, :detalle_debito_id, :monto, :fecha, :produccion_id, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

 
end