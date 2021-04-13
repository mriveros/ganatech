class VNotificacionPersona < ActiveRecord::Base
  
  self.table_name= "v_notificaciones_personas"
  self.primary_key = "notificacion_persona_id"
  
  attr_accessible :id, :descripcion, :persona_id, :nombre_persona, :apellido_persona, :created_at, :updated_at
 
  scope :orden_01, -> { order("notificacion_usuario_id")}
  scope :orden_descripcion, -> { order("descripcion")}

end