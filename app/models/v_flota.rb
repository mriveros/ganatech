class VFlota < ActiveRecord::Base

	self.table_name="v_flotas"
	self.primary_key="id"
  
  attr_accessible :id, :codigo_flota, :marca_id, :marca, :descripcion, :modelo, :chapa
 
  scope :orden_01, -> { order("id")}

  
end
