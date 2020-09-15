class VRegistroGasto < ActiveRecord::Base
  
  	self.table_name = "v_registros_gastos"
	
	self.primary_key = "registro_gasto_id"

  	attr_accessible :registro_gasto_id, :gasto_id, :gasto, :fecha, :monto, :observacion, :created_at, :updated_at
 
  	scope :orden_01, -> { order("registro_gasto_id")}


  
end