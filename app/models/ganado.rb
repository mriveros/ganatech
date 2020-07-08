class GanadoEntrada < ActiveRecord::Base

  self.table_name="ganados_entradas"
  self.primary_key="id"
  
  attr_accessible :id, :nombre, :rp, :rp_padre, :rp_madre, 
  :fecha_nacimiento, :codigo_rfid, :potrero_id, :peso_promedio, 
  :sexo_ganado_id, :tipo_ganado_id, :raza_id, :tipo_concepcion_id, :reproduccion_id, 
  :observacion, :estado_ganado_id, :etapa_ganado_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end