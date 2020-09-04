class VDerivadoLacteo < ActiveRecord::Base

  self.table_name="v_derivados_lacteos"
  self.primary_key="id"
  
  attr_accessible :derivado_lacteo_id, :tipo_derivado_id, :tipo_derivado, :cantidad_inicial, :cantidad_actual, :tipo_medicion_id, :tipo_medicion,
  :alta_produccion_queso_id, :periodo_produccion_queso, :alta_produccion_detalle_id, :estado_derivado_lacteo_id, :estado_derivado_lacteo
  scope :orden_01, -> { order("derivado_lacteo_id")}
  
end