class PagoSalarioDetalle < ActiveRecord::Base

  self.table_name="pagos_salarios_detalles"
  self.primary_key="id"
  
  attr_accessible :id, :pago_salario_id, :personal_id, :cargo_id, :salario_base, :adelantos, :descuentos, :otras_remuneraciones, :salario_percibido,
   :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  

  
end