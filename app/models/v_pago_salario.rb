class VPagoSalario < ActiveRecord::Base

  self.table_name="v_pagos_salarios"
  self.primary_key="pago_salario_id"
  
  attr_accessible :pago_salario_id, :fecha, :mes_periodo, :anho_periodo, :hacienda_id, :hacienda,
   :total_salario, :total_adelantos, :total_descuentos, :total_remunericiones_extras, :monto_total_pagado,
   :created_at, :updated_at
  
  scope :orden_01, -> { order("pago_salario_id")}
  scope :periodo_mes_anho, -> { order("mes_periodo, anho_periodo DESC")}

  
end