module Api

    module V1

		class WebServiceTuteladoController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show

  				if  params[:usuario_id].present?

  					puts "************************************************IN!"
  					usuario = Usuario.where("id = ?", params[:usuario_id]).first
  					personas_relacionadas = PersonaRelacion.where("persona_relacionada_id = ?", usuario.persona_id)
  					@response =  VMatriculacionDetalleV5.select("matriculacion_detalle_id, estudiante_id, estudiante_nombre, estudiante_apellido ").where("estudiante_id in (?) and periodo_escolar_id = ?", personas_relacionadas.map(&:persona_id), PARAMETRO[:periodo_actual] )				 

				end

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	