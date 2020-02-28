class Perfil < ActiveRecord::Base

  attr_accessible :rol_id, :usuario_id

  has_many :usuarios, foreign_key: 'perfil_actual_id', :dependent => :restrict_with_error

  belongs_to :rol
  belongs_to :usuario

end
