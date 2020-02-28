class UsuarioSerializer < ActiveModel::Serializer

  attributes :id, :persona_id, :login, :active

  belongs_to :persona

	class PersonasSerializer < ActiveModel::Serializer

    	attributes :id, :nombre_persona


	end

end