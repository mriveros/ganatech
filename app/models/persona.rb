class Persona < ActiveRecord::Base
  
  attr_accessible :id, :documento_persona, :nombre_persona, :apellido_persona, :tipo_documento_id, :genero_id, :fecha_nacimiento, :nacionalidad_id, :numero_oficina, :fecha_inscripcion, :folio, :libro, :acta, :direccion, :jurisdiccion_id, :localidad_id, :numero_casa, :nombre_edificio, :numero_apartamento, :telefono, :celular, :correo_electronico, :carnet_indigena, :estado_civil_id, :barrio_localidad, :comunidad_indigena
 
  scope :orden_01, -> { order("nombre_persona, apellido_persona")}
  scope :joins_01, -> { joins("left join jurisdicciones on personas.jurisdiccion_id = jurisdicciones.id left join departamentos on jurisdicciones.departamento_id = departamentos.id left join paises on departamentos.pais_id = paises.id")}
  has_one :usuario, :class_name => 'Usuario', :foreign_key => 'persona_id'

  belongs_to :tipo_documento
  belongs_to :nacionalidad 
  belongs_to :jurisdiccion
  belongs_to :localidad
  belongs_to :estado_civil
  belongs_to :genero, foreign_key: :genero_id

  has_many :usuarios
  has_many :personas_caracteristicas
  has_many :recepciones_alimentacion_escolar

  def nombre_completa

    "#{self.nombre_persona} #{self.apellido_persona}"

  end

  def usuario_email
     
    usuario = Usuario.where("persona_id = ?", self.id).first 
    usuario.present? ? usuario.email : nil

  end

end
