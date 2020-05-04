class VControlGanado < ActiveRecord::Base

  self.table_name="v_controles_ganados"
  self.primary_key="control_ganado_id"
  
  attr_accessible :control_ganado_id, :ganado_id, :ganado_nombre, :ganado_rp , 
  :control_id, :control, :medicamento_id, :medicamento, :peso, 
  :observacion, :fecha_control ,:created_at, :updated_at
  
  scope :orden_01, -> { order("control_ganado_id")}
  
end