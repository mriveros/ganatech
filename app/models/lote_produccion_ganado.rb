class LoteProduccionGanado < ActiveRecord::Base

  self.table_name="tmp_lote_produccion_ganado"
  attr_accessible :id, :alta_produccion_detalle_id, :created_at, :updated_at
  
  scope :orden_01, -> {order("id")}

  scope :orden_ganado, -> { order("ganado_id")}

  
end