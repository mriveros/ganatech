class Alimentacion < ActiveRecord::Base

  self.table_name="alimentaciones"

  attr_accessible :id, :descripcion, :nombre_alimento, :cantidad_stock, :cantidad_aplicacion, :ciclo, :intervalo_tiempo,
  :observacion, :tipo_alimentacion_id, :estado_alimento_id, :created_at, :updated_at

  scope :orden_01, -> {order("id")}
  scope :orden_descripcion, -> {order("nombre_alimento")}

end
