class ClasificacionSalida < ActiveRecord::Base

  self.table_name= "clasificaciones_salidas"
  attr_accessible :id, :descripcion, :created_at, :updated_at
  
  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> { order("descripcion")}
  scope :salida_faena_por_ganado, -> { where("id = ?", PARAMETRO[:clasificacion_salida_por_ganado])}

end