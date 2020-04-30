class TipoConcepcion < ActiveRecord::Base
  
  self.table_name= "tipos_concepciones"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}

  
end