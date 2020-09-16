class VPersonal < ActiveRecord::Base

  self.table_name="v_personales"
  self.primary_key="personal_id"
  
  attr_accessible :personal_id, :nombre, :apellido, :ruc_ci, :direccion, :telefono, :email, :cargo_id, :cargo, 
  :sueldo, :hacienda_id, :hacienda, :estado_personal_id, :estado_personal, :observacion
  
  scope :orden_01, -> { order("personal_id")}
  
end