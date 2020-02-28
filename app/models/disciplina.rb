class Disciplina < ActiveRecord::Base

  attr_accessible :id, :descripcion, :descripcion_guarani
  
  scope :orden_id, -> {order("id")}

  has_many :materiales_educativos, class_name: "MaterialEducativo"
  
end