class InfraestructuraCaracteristicaOpcion < ActiveRecord::Base

  has_many :infraestructuras_fiscalizaciones_detalles, :dependent => :restrict_with_error

end
