class VProduccionDetalleDebito < ActiveRecord::Base

	self.table_name="v_producciones_detalles_debitos"
	self.primary_key="id"
  
  attr_accessible :produccion_detalle_debito_id, :detalle_debito_id, :detalle_debito, :produccion_id, :monto, :fecha, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

 
end