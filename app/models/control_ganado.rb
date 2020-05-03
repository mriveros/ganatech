class ControlGanado < ActiveRecord::Base

  self.table_name="controles_ganados"
  self.primary_key="id"
  
  attr_accessible :id, :ganado_id, :control_id, :medicamento_id, :peso, :observacion, :fecha_control ,:created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end