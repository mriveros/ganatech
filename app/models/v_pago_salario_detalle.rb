class VPagoSalarioDetalle < ActiveRecord::Base

  self.table_name="v_pagos_salarios_detalles"
  self.primary_key="pago_salario_detalle_id"
  
  attr_accessible :pago_salario_detalle_id, :pago_salario_id, :personal_id, :personal_nombre, :personal_apellido, :personal_ruc_ci, :cargo_id, :cargo, :salario_base, :adelantos, :descuentos, :otras_remuneraciones, :salario_percibido 
   :created_at, :updated_at
  
  scope :orden_01, -> { order("pago_salario_detalle_id")}
  

  
end