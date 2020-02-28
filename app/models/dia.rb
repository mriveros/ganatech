class Dia < ActiveRecord::Base

  self.table_name="dias"
  
  attr_accessible :id, :descripcion
  
end