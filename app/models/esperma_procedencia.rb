class EspermaProcedencia < ActiveRecord::Base
  
  self.table_name= "espermas_procedecias"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion,  :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

  
end