class Potrero < ActiveRecord::Base

  self.table_name="potreros"
  self.primary_key="id"
  
  attr_accessible :id, :descripcion, :hectareas, :hacienda_id, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("id")}
  
end