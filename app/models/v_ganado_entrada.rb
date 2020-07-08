class VGanadoEntrada < ActiveRecord::Base

  self.table_name= "v_ganados_entradas"
  self.primary_key= "ganado_entrada_id"
  
  attr_accessible :ganado_entrada_id, :peso_promedio, :sexo_ganado_id, :sexo_ganado, :tipo_ganado_id, :tipo_ganado, :raza_id, :raza, :tipo_concepcion_id, :tipo_concepcion, :observacion, :etapa_ganado_id , :etapa_ganado, :created_at, :updated_at
  
  scope :orden_01, -> { order("ganado_id")}
  
end