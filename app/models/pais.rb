class Pais < ActiveRecord::Base

  attr_accessible :descripcion, :codigo

  scope :orden_descripcion, -> { order('descripcion')}

  belongs_to :departamento

  has_many :personas, :dependent => :restrict_with_error

end
