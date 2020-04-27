class VPotrero < ActiveRecord::Base

  self.table_name="v_potreros"
  self.primary_key="potrero_id"
  
  attr_accessible :id, :potrero, :hectareas, :hacienda_id, :hacienda, :departamento_id, :departamento, :jurisdiccion_id, :jurisdiccion ,:observacion, :created_at, :updated_at
  scope :orden_01, -> { order("potrero_id")}
  
end