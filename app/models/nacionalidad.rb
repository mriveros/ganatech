class Nacionalidad < ActiveRecord::Base

  default_scope -> { where("descripcion is not null")}

  scope :ordenado_descripcion, -> { order('descripcion')}
	
  has_many :personas
	
end
