class TipoDocumento < ActiveRecord::Base

  attr_accessible :codigo, :descripcion
  
  scope :ordenado_descripcion, -> { order('descripcion')}
  scope :habilitados, -> { where("id in (?)", [1,3,4,5,6])}
  scope :superior, -> { where("id in (?)", [1,3,4])}

  has_many :personas

end
