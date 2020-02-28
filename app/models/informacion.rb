class Informacion < ActiveRecord::Base

#self.table_name="informaciones"
	
  attr_accessible :id, :titulo, :contenido
  
  scope :orden_id, -> {order("id")}
	
	has_many :informacion_enlace

end
