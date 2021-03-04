class EstadoOrdenTrabajo < ActiveRecord::Base

  self.table_name="estados_ordenes_trabajos"
  attr_accessible :id, :descripcion

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end