class VMedicamento < ActiveRecord::Base

  self.table_name="v_medicamentos"

  attr_accessible :medicamento_id, :medicamento, :nombre_medicamento, :cantidad_stock, :cantidad_aplicacion,
  :ciclo, :intervalo_tiempo, :observacion, :estado_medicamento_id, :estado_medicamento,
  :tipo_presentacion_id, :tipo_presentacion, :tipo_administracion_id, :tipo_administracion,
  :fecha_vencimiento, :created_at, :updated_at
  
  scope :orden_01, -> {order("medicamento_id")}
  scope :disponible, -> {where("cantidad > 0")}

  
end