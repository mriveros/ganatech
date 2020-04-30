class EtapaGanado < ActiveRecord::Base

  self.table_name="etapas_ganados"
  attr_accessible :id, :descripcion, :sexo_ganado_id, :tipo_ganado_id, :created_at, :updated_at
  
  scope :orden_01, -> {order("id")}

end