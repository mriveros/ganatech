class Acceso < ActiveRecord::Base
  
  attr_accessible :rol_id, :accion_id

  scope :orden_id, -> {order("id")}

  belongs_to :rol
  belongs_to :accion, class_name: "Accion", foreign_key: 'accion_id'

end
