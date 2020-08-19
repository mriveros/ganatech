class ProveedorGanado < ActiveRecord::Base

  self.table_name="proveedores_ganados"
  self.primary_key = 'id'
  attr_accessible :id, :nombre_razon_social, :ruc_ci, :direcccion, :telefono, :email, :observacion, :created_at, :updated_at

  scope :orden_id, -> {order("id")}

end
