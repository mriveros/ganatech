class Precio < ActiveRecord::Base
  
  self.table_name= "precios"
  self.primary_key = "id"
  
  attr_accessible :id, :codigo, :descripcion, :monto, :created_at, :updated_at, :predeterminado
 
  scope :orden_01, -> { order("id")}

  
end
