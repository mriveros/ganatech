class VGanado < ActiveRecord::Base

  self.table_name= "v_ganados"
  self.primary_key= "ganado_id"
  
  attr_accessible :ganado_id, :nombre, :rp, :rp_padre, :rp_madre, :fecha_nacimiento, :codigo_rfid, :potrero_id, :potrero, :peso_promedio, :sexo_ganado_id, :sexo_ganado, :tipo_ganado_id, :tipo_ganado, :raza_id, :raza, :tipo_concepcion_id, :tipo_concepcion, :reproduccion_id, :observacion, :estado_ganado_id, :estado_ganado, :etapa_ganado_id , :etapa_ganado, :created_at, :updated_at
  
  scope :orden_01, -> { order("ganado_id")}

  scope :modulo_ganado_salida, -> { where("estado_ganado_id not in (?)", [PARAMETRO[:estado_ganado_en_proceso_venta], PARAMETRO[:estado_ganado_vendido]])}
  
  scope :group_01, -> {group("estado_ganado, ganado_id, nombre,rp, rp_padre ,rp_madre,fecha_nacimiento,codigo_rfid,hacienda_id,hacienda, potrero_id,potrero,peso_promedio,  
	sexo_ganado_id, sexo_ganado,tipo_ganado_id, tipo_ganado, raza_id ,raza, tipo_concepcion_id ,tipo_concepcion,reproduccion_id,
	observacion,estado_ganado_id,etapa_ganado_id ,etapa_ganado, created_at , updated_at , finalidad_ganado_id ,finalidad_ganado, codigo_lote, ganado_entrada_id, procedencia,
	proveedor_ganado_id, nombre_razon_social ")}

  scope :orden_estado, -> { order("estado_ganado_id,codigo_lote DESC")}

  scope :modulo_control_ganado, -> { where("estado_ganado_id not in (?)", [PARAMETRO[:estado_ganado_vendido], PARAMETRO[:estado_ganado_muerto]])}

  scope :modulo_ganados, -> { where("estado_ganado_id not in (?)", [PARAMETRO[:estado_ganado_vendido]])}


end