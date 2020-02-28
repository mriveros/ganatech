class Sistema < ActiveRecord::Base

  self.table_name="sistemas"

  scope :ordenado_id, -> { order('id') }
  scope :ordenado_descripcion, -> { order('descripcion') }

end
