class Medicamento < ActiveRecord::Base

  self.table_name="medicamentos"
  self.primary_key="id"
  
  attr_accessible  :id, :descripcion, :nombre_medicamento, :cantidad_stock, :cantidad_aplicacion, :ciclo, :intervalo_tiempo, :observacion, :estado_medicamento_id, :tipo_presentacion_id, :tipo_administracion_id, :fecha_vencimiento, :costo
  
  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> { order("nombre_medicamento")}

  
end