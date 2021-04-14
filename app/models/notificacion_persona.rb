class NotificacionPersona < ActiveRecord::Base
  
  self.table_name= "notificaciones_personas"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :persona_id, :created_at, :updated_at, :estado
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end