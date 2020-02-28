class Controlador < ActiveRecord::Base
  
  attr_accessible :descripcion

  scope :ordenado_id, -> {order("id")}
  scope :ordenado_descripcion, -> {order("descripcion")}

  has_many :acciones, :dependent => :restrict_with_error

  validates :descripcion, presence: true

end
