class LoteGanadoFaena < ActiveRecord::Base

  self.table_name="tmp_ganados_faenas_lotes"
  attr_accessible :id, :ganado_id, :created_at, :updated_at
  
  scope :orden_01, -> {order("id")}

  scope :orden_ganado, -> { order("ganado_id")}

  
end