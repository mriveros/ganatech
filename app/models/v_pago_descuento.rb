class VPagoDescuento < ActiveRecord::Base

  self.table_name="v_pagos_descuentos"
  self.primary_key="pago_descuento_id"
  
  attr_accessible :pago_descuento_id, :fecha, :personal_id, :personal_nombre, :personal_apellido,
   :monto, :mes_periodo, :anho_periodo, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("pago_descuento_id")}
  scope :orden_fecha_desc, -> { order("fecha DESC")}
  
end