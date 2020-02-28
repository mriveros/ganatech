class Accion < ActiveRecord::Base
  
  attr_accessible :controlador_id, :descripcion

  scope :orden_id, -> {order("id")}

  belongs_to :controlador

  has_many :accesos, :dependent => :restrict_with_error

end