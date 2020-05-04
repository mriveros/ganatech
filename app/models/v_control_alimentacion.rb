class VControlAlimentacion < ActiveRecord::Base

  self.table_name="v_controles_alimentacion"
  self.primary_key="control_alimentacion_id"
  
  attr_accessible :control_alimentacion_id, :fecha_control , :ganado_id, :ganado_nombre, :ganado_rp, :tipo_alimentacion_id, :tipo_alimentacion, :alimentacion_id, :alimentacion, :cantidad_suministrada, :observacion, :created_at, :updated_at
  
  scope :orden_01, -> { order("control_alimentacion_id")}
  
end