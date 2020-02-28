class VProduccionDetalleCredito < ActiveRecord::Base

	self.table_name="v_producciones_detalles_creditos"
	self.primary_key="id"
  
  attr_accessible :produccion_detalle_credito_id, :detalle_credito_id, :detalle_credito, :produccion_id, :monto, :fecha, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

 
end