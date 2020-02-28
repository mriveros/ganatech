class Produccion < ActiveRecord::Base
  
  attr_accessible :id, :codigo_produccion, :fecha_produccion, :persona_id, :destino,:gasoil_actual, :cliente_id, :observaciones, :costo, :estado_produccion_id, :cobrado, :pertenece, :flota_id
 
  scope :orden_01, -> { order("id")}

 
end
