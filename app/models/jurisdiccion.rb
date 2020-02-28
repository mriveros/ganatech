class Jurisdiccion < ActiveRecord::Base

  attr_accessible :descripcion, :codigo, :departamento_id, :estado

  scope :orden_descripcion, -> { order('descripcion')}

  belongs_to :departamento

  has_many :personas, :dependent => :restrict_with_error
  has_many :localidades, :dependent => :restrict_with_error

end
