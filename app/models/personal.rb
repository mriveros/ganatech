class Personal < ActiveRecord::Base

  self.table_name="personales" 
  self.primary_key="id"
  
  attr_accessible :id, :nombre, :apellido, :ruc_ci, :direccion, :telefono, :email, :cargo_id, :hacienda_id, :estado_personal_id, :observacion
  
  scope :nombre_apellido, -> { select( "id, nombre || ' ' || apellido as nombre_apellido")} 
  scope :orden_01, -> { order("id")}
  
end