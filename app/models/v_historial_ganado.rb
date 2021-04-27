class VHistorialGanado < ActiveRecord::Base

  self.table_name="v_historiales_ganados"
  self.primary_key="historial_ganado_id"
  
  attr_accessible :id, :ganado_id, :modulo, :accion, :fecha, :cantidad_suministrada, :peso,
  :created_at, :updated_at, :control_ganado_id, :control_alimentacion_id, :celo_id, :reproduccion_id,
  :ganado_enfermo_id, :alta_produccion_id, :ganado_salida_id, :ganado_faena_detalle_id
  
  scope :orden_01, -> { order("historial_ganado_id")}
  
end