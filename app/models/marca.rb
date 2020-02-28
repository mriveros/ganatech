class Marca < ActiveRecord::Base

  self.table_name="marcas"
  attr_accessible :id, :descripcion
  
  scope :orden_id, -> {order("id")}

end
