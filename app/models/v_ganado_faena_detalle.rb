class VGanadoFaenaDetalle < ActiveRecord::Base

  self.table_name="v_ganados_faenas_detalles"
  self.primary_key="id"
  
  attr_accessible :ganado_faena_id, :ganado_faena_id, :ganado_id, :ganado_rp, :ganado_nombre, :ganado_rfid, :peso_vivo, :peso_neto, :monto_peso, :monto, :created_at, :updated_at, :rendimiento
  
  scope :orden_01, -> { order("id")}
  
end