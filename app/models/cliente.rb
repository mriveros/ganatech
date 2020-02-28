class Cliente < ActiveRecord::Base

  #self.table_name="clientes"
  #self.primary_key="id"
  
  attr_accessible :id, :razon_social, :cliente_nombre, :cliente_apellido, :direccion, :telefono
  
  scope :orden_01, -> { order("id")}
  
end