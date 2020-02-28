class ProduccionDetalleCredito < ActiveRecord::Base

	self.table_name="producciones_detalles_creditos"
	self.primary_key="id"
  
  attr_accessible :id, :detalle_credito_id, :monto, :fecha, :produccion_id, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

 
end
