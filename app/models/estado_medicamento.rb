class EstadoMedicamento < ActiveRecord::Base
  
  self.table_name= "estados_medicamentos"
  self.primary_key = "id"
  
  attr_accessible :id, :descripcion,  :created_at, :updated_at
  
  scope :orden_01, -> { order("id")}
  scope :orden_descripcion, -> { order("descripcion")}
  scope :dar_baja, -> { where("id = ?", 4)}

  
end
