class InformacionRol < ActiveRecord::Base

	self.table_name="informaciones_roles"
  attr_accessible :id, :informacion_id, :rol_id
  
  scope :orden_id, -> {order("id")}
	
	 belongs_to :rol
	 belongs_to :informaciones

end
