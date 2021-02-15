class VGanadoFaena < ActiveRecord::Base

  self.table_name="v_ganados_faenas"
  self.primary_key="id"
  
  attr_accessible :id, :descripcion, :motivo_faena_id, :motivo_faena, :fecha, :cantidad, :monto_total, :created_at, :updated_at, :cliente_id, :nombre_razon_social, :ruc_ci, :clasificacion_salida_id, :clasificacion_salida
  
  scope :orden_01, -> { order("id")}
  scope :orden_fecha, -> { order("fecha desc")}
  
end