class DerivadoLacteoDetalle < ActiveRecord::Base

  self.table_name="derivados_lacteos_detalles"
  self.primary_key="id"
  
  attr_accessible :id, :derivado_lacteo_id ,:tipo_salida_derivado_id, :cantidad_salida, :monto,
  :fecha_salida, :observacion
  scope :orden_01, -> { order("id")}
  
end