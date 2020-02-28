class InformacionEnlace < ActiveRecord::Base

#self.table_name="informaciones_enlaces"
	
  attr_accessible :id, :titulo, :enlace, :informacion_id
  
  scope :orden_id, -> {order("id")}
	
  
	belongs_to :informacion, class_name: 'Informacion', foreign_key: :informacion_id

end
