class VOrdenTrabajo < ActiveRecord::Base

  self.table_name="v_ordenes_trabajos"
  attr_accessible :id, :descripcion, :trabajo_id, :trabajo, :fecha_trabajo, :estado_orden_trabajo_id, :estado_orden_trabajo, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end