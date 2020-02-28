class InfraestructuraDetalleOpcion < ActiveRecord::Base

  attr_accessible :infraestructura_fiscalizacion_detalle_id, :infraestructura_parte_id, :infraestructura_caracteristica_id, :infraestructura_caracteristica_opcion_id, :valor

  scope :ordenado_01, -> { order("infraestructura_fiscalizacion_detalle_id")}

  belongs_to :infraestructura_fiscalizacion_detalle
  belongs_to :infraestructura_parte
  belongs_to :infraestructura_caracteristica
  belongs_to :infraestructura_caracteristica_opcion

end
