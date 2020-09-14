class Personal < ActiveRecord::Base

  self.table_name="personales"
  self.primary_key="id"
  
  attr_accessible :id, :nombre, :apellido, :ruc_ci, :direccion, :telefono, :email, :cargo_id, :observacion
  
  scope :orden_01, -> { order("id")}
  
end