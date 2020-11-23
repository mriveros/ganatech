class VAlimentacion < ActiveRecord::Base

  self.table_name="v_alimentaciones"
  self.primary_key="alimentacion_id"

  attr_accessible :alimentacion_id, :nombre_alimento, :descripcion_alimento, :cantidad_stock, :cantidad_aplicacion, :ciclo,
  :intervalo_tiempo, :estado_alimento_id, :estado_alimento, :tipo_alimentacion_id, :tipo_alimento,
  :fecha_vencimiento, :created_at, :updated_at

  scope :orden_01, -> { order("alimentacion_id")}
  scope :disponible, -> { where("cantidad_stock > 0")}

end
