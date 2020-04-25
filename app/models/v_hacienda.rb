class VHacienda < ActiveRecord::Base

	self.table_name="v_haciendas"
	self.primary_key="hacienda_id"
  
  attr_accessible :hacienda_id, :hacienda, :posicion_x, :posicion_y, :departamento, :departamento_id, :jurisdiccion, :jurisdiccion_id, :observacion, :created_at, :updated_at
 
  scope :orden_01, -> { order("hacienda_id")}

  
end
