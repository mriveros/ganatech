class Clasificacion < ActiveRecord::Base

  self.table_name= "clasificaciones"
  attr_accessible :id, :descripcion, :created_at, :updated_at
  
  scope :orden_01, -> {order("id")}

  scope :orden_descripcion, -> { order("descripcion")}

  
end