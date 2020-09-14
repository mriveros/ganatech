class VPersonal < ActiveRecord::Base

  self.table_name="v_personales"
  self.primary_key="id"
  
  attr_accessible :id, :nombre, :apellido, :ruc_ci, :direccion, :telefono, :email, :cargo_id, :cargo, :sueldo, :observacion
  
  scope :orden_01, -> { order("id")}
  
end