class EstadoAlimentacion < ActiveRecord::Base

  self.table_name="estados_alimentaciones"
  attr_accessible :id, :descripcion

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end
