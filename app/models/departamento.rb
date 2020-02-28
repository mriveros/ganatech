class Departamento < ActiveRecord::Base

  attr_accessible :descripcion, :codigo, :pais_id, :estado

  scope :orden_descripcion, -> { order('descripcion')}
  scope :paraguay, -> { where("pais_id = ? and estado = true", 1)}

  belongs_to :pais

  has_many :jurisdicciones, :dependent => :restrict_with_error
  scope :ordenar_descripcion, -> {order('descripcion')}
  scope :descendente, -> {order('id desc')}
  scope :orden_id, -> {order('id')}
  scope :correctos, -> {where("departamentos.id not in (99, 19, 100)")}
  scope :paraguay, -> {where('pais_id = 1')}
  scope :activo, -> {where("departamentos.estado = true")}

end
