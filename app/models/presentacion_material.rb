class PresentacionMaterial < ActiveRecord::Base

  self.table_name="presentaciones_materiales"
  attr_accessible :id, :descripcion

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end