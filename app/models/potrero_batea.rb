class PotreroBatea < ActiveRecord::Base

  self.table_name="potreros_bateas"
  self.primary_key="id"
  
  attr_accessible :id, :potrero_id, :descripcion, :capacidad, :porcentaje, :observacion, :created_at, :updated_at
  scope :orden_01, -> { order("id")}
  
end