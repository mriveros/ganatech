class MotivoFaena < ActiveRecord::Base

  self.table_name="motivos_faenas"
  attr_accessible :id, :descripcion
  
  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("descripcion")}

end