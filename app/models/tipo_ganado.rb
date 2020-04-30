class TipoGanado < ActiveRecord::Base

  self.table_name="tipos_ganados"
  attr_accessible :id, :descripcion
  
  scope :orden_01, -> {order("id")}

end