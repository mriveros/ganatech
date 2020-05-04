class TipoAlimentacion < ActiveRecord::Base

  self.table_name="tipos_alimentaciones"
  attr_accessible :id, :descripcion
  
  scope :orden_01, -> {order("id")}

end