class GrupoSanguineo < ActiveRecord::Base

  self.table_name="grupos_sanguineos"

  scope :orden_id, -> {order('id')}

end
