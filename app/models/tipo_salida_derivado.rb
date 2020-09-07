class TipoSalidaDerivado < ActiveRecord::Base

  self.table_name="tipos_salidas_derivados"
  attr_accessible :id, :descripcion

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end
