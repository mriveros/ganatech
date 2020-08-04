class VGanado < ActiveRecord::Base

  self.table_name= "v_ganados"
  self.primary_key= "ganado_id"
  
  attr_accessible :ganado_id, :nombre, :rp, :rp_padre, :rp_madre, :fecha_nacimiento, :codigo_rfid, :potrero_id, :potrero, :peso_promedio, :sexo_ganado_id, :sexo_ganado, :tipo_ganado_id, :tipo_ganado, :raza_id, :raza, :tipo_concepcion_id, :tipo_concepcion, :reproduccion_id, :observacion, :estado_ganado_id, :estado_ganado, :etapa_ganado_id , :etapa_ganado, :created_at, :updated_at
  
  scope :orden_01, -> { order("ganado_id")}

  scope :modulo_ganado_salida, -> { where("estado_ganado_id not in (?)", [PARAMETRO[:estado_ganado_en_proceso_venta], PARAMETRO[:estado_ganado_vendido]])}
  
end