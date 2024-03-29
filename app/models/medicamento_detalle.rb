class MedicamentoDetalle < ActiveRecord::Base

  self.table_name="medicamentos_detalles"

  attr_accessible :id, :medicamento_id, :descripcion, :fecha_suministro, :numero_lote,
  :cantidad_suministro, :observacion, :created_at, :updated_at, :fecha_vencimiento
  scope :orden_01, -> {order("id")}
  scope :orden_date, -> {order("created_at desc")}
  scope :numero_lote, -> {order("numero_lote asc")}

  
end