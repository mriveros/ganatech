class OrdenTrabajo < ActiveRecord::Base

  self.table_name="ordenes_trabajos"
  attr_accessible :id, :descripcion, :fecha_trabajo, :trabajo_id, :material_id, :cantidad_utilizada, :estado_orden_trabajo_id, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end