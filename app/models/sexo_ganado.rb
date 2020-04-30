class SexoGanado < ActiveRecord::Base

  self.table_name="sexos_ganados"
  attr_accessible :id, :descripcion
  
  scope :orden_id, -> {order("id")}

end