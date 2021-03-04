class AuxCompra < ActiveRecord::Base

  self.table_name="_aux_compras"
  self.primary_key="id"
  
  attr_accessible :id, :fecha, :descripcion, :monto, :observacion, :created_at,  :updated_at
  
  scope :orden_01, -> { order("id" )}
  scope :orden_fecha, -> { order("fecha desc" )}
  
end