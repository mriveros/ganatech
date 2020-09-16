class PagoDescuento < ActiveRecord::Base

  self.table_name="pagos_descuentos"
  self.primary_key="id"
  
  attr_accessible :id, :fecha, :personal_id, :monto, :mes_periodo, :anho_periodo, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("id")}
  
end