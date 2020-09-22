class VPagoAdelanto < ActiveRecord::Base

  self.table_name="v_pagos_adelantos"
  self.primary_key="pago_adelanto_id"
  
  attr_accessible :pago_adelanto_id, :fecha, :personal_id, :personal_nombre, :personal_apellido,
   :monto, :mes_periodo, :anho_periodo, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("pago_adelanto_id")}
  scope :orden_fecha_desc, -> { order("fecha DESC")}
  
  
end