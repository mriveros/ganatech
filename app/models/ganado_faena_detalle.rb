class GanadoFaenaDetalle < ActiveRecord::Base

  self.table_name="ganados_faenas_detalles"
  self.primary_key="id"
  
  attr_accessible :id, :ganado_faena_id, :ganado_id, :peso_vivo, :peso_neto, :monto_peso, :monto, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end