class NotificacionUsuario < ActiveRecord::Base
  
  self.table_name= "notificaciones_usuarios"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion, :usuario_id, :created_at, :updated_at
 
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}

end