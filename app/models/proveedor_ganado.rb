class ProveedorGanado < ActiveRecord::Base

  self.table_name="proveedores_ganados"
  self.primary_key = 'id'
  attr_accessible :id, :nombre, :direcccion, :telefono, :ruc, :nombre_fantasia, :correo_electronico, :jurisdiccion_id
  
  scope :orden_id, -> {order("id")}

end
