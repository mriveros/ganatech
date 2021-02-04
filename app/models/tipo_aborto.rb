class TipoAborto < ActiveRecord::Base

  self.table_name="tipos_abortos"
  attr_accessible :id, :descripcion

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end