class Tutor < ActiveRecord::Base

  self.table_name="tutores"
  self.primary_key="id"
  
  attr_accessible :id, :persona_id
  
  scope :orden_01, -> { order("id")}
  
end