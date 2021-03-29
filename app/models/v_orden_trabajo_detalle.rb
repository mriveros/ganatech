class VOrdenTrabajoDetalle < ActiveRecord::Base

  self.table_name="v_ordenes_trabajos_detalles"

  attr_accessible :orden_trabajo_detalle_id, :orden_trabajo_id ,:material_id, :material, :cantidad_utilizada, :created_at, :updated_at

  scope :orden_01, -> {order("orden_trabajo_detalle_id")}
  scope :orden_material, -> {order("material")}

end