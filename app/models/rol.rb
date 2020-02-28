class Rol < ActiveRecord::Base
  
  attr_accessible :descripcion

  scope :ordenado_id, -> {order("id")}
  scope :ordenado_descripcion, -> {order("descripcion")}
  scope :rol_usuario_oferta_educativa, -> { where("id in (3, 11,44)") }

  has_many :accesos, :dependent => :restrict_with_error
  has_many :perfiles, :dependent => :restrict_with_error

  validates :descripcion, presence: true

end
