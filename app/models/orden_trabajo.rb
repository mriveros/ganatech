class OrdenTrabajo < ActiveRecord::Base

  self.table_name="ordenes_trabajos"
  attr_accessible :id, :descripcion, :trabajo_id, :fecha_trabajo, :estado_orden_trabajo_id, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end