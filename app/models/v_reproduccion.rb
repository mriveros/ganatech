class VReproduccion < ActiveRecord::Base

  self.table_name="v_reproducciones"
  self.primary_key="reproduccion_id"
  
  attr_accessible :reproduccion_id, :ganado_reproductor_id, :ganado_reproductor_nombre, :ganado_reproductor_rp,
  :ganado_reproductor_rfid, :celo_id, :celo_ganado_rfid, :celo_ganado_nombre, :celo_ganado_rp,
  :esperma_id, :esperma_descripcion, :esperma_ganado_id, :numero_pajuela, :esperma_raza_id,
  :esperma_procedencia_id, :esperma_procedencia, :ganado_esperma_rfid, :ganado_esperma_nombre, :ganado_esperma_rp,
  :fecha_reproduccion, :fecha_concepcion, :descripcion, :potrero_id, :potrero, :hacienda_id, :hacienda, 
  :estado_reproduccion_id, :estado_reproduccion, :observacion, :created_at, :updated_at, :inseminador, :tipo_aborto, 
  :tipo_aborto_id
  scope :orden_01, -> { order("reproduccion_id")}
  scope :fecha_creacion, -> { order("estado_reproduccion_id")}
  
end