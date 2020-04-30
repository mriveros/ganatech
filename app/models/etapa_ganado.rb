class EtapaGanado < ActiveRecord::Base

  self.table_name="etapas_ganados"
  attr_accessible :id, :descripcion
  
  scope :orden_id, -> {order("id")}

end