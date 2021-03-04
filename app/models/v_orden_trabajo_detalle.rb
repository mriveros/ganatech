class VOrdenTrabajoDetalle < ActiveRecord::Base

  self.table_name="v_ordenes_trabajos_detalles"

  attr_accessible :id, :material_id, :material, :cantidad_utilizada, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end