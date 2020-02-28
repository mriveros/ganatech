class Flota < ActiveRecord::Base
  
  attr_accessible :id, :descripcion, :marca_id, :modelo, :chapa
 
  scope :orden_01, -> { order("id")}

  belongs_to :marca

  
end
