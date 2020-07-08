class GanadoEntrada < ActiveRecord::Base

  self.table_name="ganados_entradas"
  self.primary_key="id"
  
  attr_accessible :id, :procedencia, :peso_promedio, :precio_compra, :estado_movimiento_id,
  :observacion, :proveedor_ganado_id, :contacto_proveedor, :telefono_contacto, 
  :sexo_ganado_id, :etapa_ganado_id, :raza_ganado_id, :tipo_concepcion_id, 
  :tipo_ganado_id, :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  
end