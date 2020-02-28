class VRoles < ActiveRecord::Base
  
  self.table_name="v_roles"
  scope :ordenado_descripcion, -> {order("descripcion")}
  
end