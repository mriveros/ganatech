class VEsperma < ActiveRecord::Base

  self.table_name= "v_espermas"
  self.primary_key= "esperma_id"
  
  attr_accessible  :esperma_id, :descripcion, :ganado_id, :nombre_ganado, :ganado_rp,
  :numero_pajuela, :raza_id, :raza_ganado, :observacion, :estado_esperma_id, 
  :estado_esperma, :esperma_procedencia_id, :esperma_procedencia, :costo_esperma,
  :fecha_registro, :costo_total, :cantidad, :created_at, :updated_at, :cantidad_inicial,
  :documento_ganatec_id
  
  scope :orden_01, -> { order("esperma_id")}
  scope :orden_fecha, -> { order("fecha_registro desc")}
  scope :orden_estado, -> { order("estado_esperma_id")}
  
end