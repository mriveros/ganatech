class EstadoReproduccion < ActiveRecord::Base
  
  self.table_name= "estados_reproducciones"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

  
end