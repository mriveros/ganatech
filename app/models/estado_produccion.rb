class EstadoProduccion < ActiveRecord::Base
  
  self.table_name="estados_producciones"
  self.primary_key = 'id'

  attr_accessible :id, :descripcion 
  scope :orden_01, -> { order("id")}

end
