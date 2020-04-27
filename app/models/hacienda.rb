class Hacienda < ActiveRecord::Base
  
  self.table_name= "haciendas"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :posicion_x, :posicion_y , :departamento_id, :jurisdiccion_id, :created_at, :updated_at, :observacion
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

  
end
