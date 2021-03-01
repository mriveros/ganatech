class Material < ActiveRecord::Base

  self.table_name="materiales"
  attr_accessible :id, :nombre_material, :cantidad_stock, :estado_material_id, :presentacion_material_id, :observacion,
  :costo_unitario, :costo_total, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end