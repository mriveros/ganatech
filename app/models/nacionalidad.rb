class Nacionalidad < ActiveRecord::Base

  self.table_name="nacionalidades"
  self.primary_key="id"

  default_scope -> { where("descripcion is not null")}

  scope :ordenado_descripcion, -> { order('descripcion')}
	
  has_many :personas
	
end
