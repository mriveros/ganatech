class EmpresaTransporte < ActiveRecord::Base

  self.table_name= "empresas_transportes"
  self.primary_key = "id"

  attr_accessible :id, :nombre, :ruc_ci, :telefono, :direccion, :created_at, :updated_at

  scope :orden_01, -> { order("id")}


end
