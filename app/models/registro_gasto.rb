class RegistroGasto < ActiveRecord::Base
  
  	self.table_name = "registros_gastos"
	
	self.primary_key = "id"

  	attr_accessible :id, :gasto_id, :fecha, :monto, :observacion, :created_at, :updated_at
 
  	scope :orden_01, -> { order("id")}


  
end