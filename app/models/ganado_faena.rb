class GanadoFaena < ActiveRecord::Base

  self.table_name="ganados_faenas"
  self.primary_key="id"
  
  attr_accessible :id, :descripcion, :motivo_faena_id, :fecha, :cantidad, :monto_total, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end