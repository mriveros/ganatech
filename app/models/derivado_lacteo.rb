class DerivadoLacteo < ActiveRecord::Base

  self.table_name="derivados_lacteos"
  self.primary_key="id"
  
  attr_accessible :id, :tipo_derivado_id, :alta_produccion_queso_id, :alta_produccion_id, :cantidad_inicial,
  :cantidad_actual, :tipo_medicion_id, :estado_derivado_lacteo_id, :created_at, :updated_at
  scope :orden_01, -> { order("id")}
  
end