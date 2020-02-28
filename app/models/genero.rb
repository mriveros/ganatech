class Genero < ActiveRecord::Base

  attr_accessible :descripcion

  scope :orden_descripcion, -> { order('descripcion')}

  has_many :personas, :dependent => :restrict_with_error

end
