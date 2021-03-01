class VMaterial < ActiveRecord::Base

  self.table_name="v_materiales"
  attr_accessible :id, :nombre_material, :cantidad_stock, :estado_material_id, :estado_material, :presentacion_material_id, :presentacion_material, :observacion,
  :costo_unitario, :costo_total, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end