class Cliente < ActiveRecord::Base

  self.table_name="clientes"
  self.primary_key="id"
  
  attr_accessible :id, :nombre_razon_social, :ruc_ci, :direccion, :telefono
  
  scope :orden_01, -> { order("id")}
  
end