module Api

    module V1

		class WebServiceSeccionController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show

  				if  params[:establecimiento_id].present?  && params[:usuario_id].present?

  					@response = SigmecSeccion.select("id_puesto as establecimiento_id,id_ref_rue_seccion as rue_seccion_id, codigo_curso as curso, nombre_turno as turno, id_persona, nombre_curriculo as especialidad, letra_numero_seccion as seccion ").where("id_persona = ? and codigo_institucion = ?",params[:usuario_id],params[:establecimiento_id] )

				end

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	