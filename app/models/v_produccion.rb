class VProduccion < ActiveRecord::Base
  
  attr_accessible :produccion_id, :codigo_produccion, :fecha_produccion, :chofer_id, :nombre_chofer, :apellido_chofer, :origen, :destino, :destino_final, :gasoil_actual, :cliente_id,:cliente_nombre, :cliente_apellido, :razon_social, :observaciones, :costo, :estado_produccion_id, :estado_produccion, :cobrado, :pertenece, :flota_id, :codigo_flota, :modelo, :marca_id, :marca
 
  scope :orden_01, -> { order("produccion_id")}

 
end