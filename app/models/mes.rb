class Mes < ActiveRecord::Base
  
  self.table_name="meses"
  
  
  scope :orden_mes, -> { order("mes")}
  
  attr_accessible :id, :mes, :descripcion
  has_many :matriculaciones_evaluaciones
  has_many :ofertas_alimentaciones
    
end