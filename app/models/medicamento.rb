class Medicamento < ActiveRecord::Base

  self.table_name="medicamentos"

  attr_accessible :id, :descripcion, :nombre_medicamento, :cantidad_stock, :cantidad_aplicacion, :ciclo, :intervalo_tiempo,
  :observacion, :estado_medicamento_id, :tipo_presentacion_id, :tipo_administracion_id, :created_at, :updated_at
  
  scope :orden_01, -> {order("id")}

  
end