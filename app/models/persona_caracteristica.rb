class PersonaCaracteristica < ActiveRecord::Base

  self.table_name="personas_caracteristicas"

  attr_accessible :persona_id, :caracteristica_id, :valor_descriptivo, :activo, :valor_numerico

  scope :joins_01, -> { joins("join caracteristicas c on personas_caracteristicas.caracteristica_id = c.id join tipos_caracteristicas tc on c.tipo_caracteristica_id = tc.id ")}

  belongs_to :persona
  belongs_to :caracteristica, class_name: "Caracteristica", foreign_key: :caracteristica_id

end
