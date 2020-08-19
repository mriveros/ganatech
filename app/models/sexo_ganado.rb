class SexoGanado < ActiveRecord::Base

  self.table_name="sexos_ganados"
  attr_accessible :id, :descripcion
  
  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end