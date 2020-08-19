class EstadoEnfermedad < ActiveRecord::Base

  self.table_name="estados_enfermedades"
  self.primary_key="id"
  
  attr_accessible :id, :descripcion, :created_at,  :updated_at;
  
  scope :orden_01, -> { order("id")}
  scope :modulo_ganados_enfermos, -> { where("id in (1,2,3)")}
  
end