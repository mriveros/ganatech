module Api

    module V1

		class WebServiceAusenciaController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show
  				@response = [["id","error"]]
  				if  params[:matriculacion_detalle_id].present?

  					matriculacion_media_detalle = MatriculacionMediaDetalle.where("matriculacion_detalle_id = ?",params[:matriculacion_detalle_id]).first	
  					if matriculacion_media_detalle.present?
  						@response = AsistenciaMedia.where("matriculacion_media_detalle_id = ? and asistencia = ?",matriculacion_media_detalle.id, false)
  					end

  					matriculacion_basica_detalle = MatriculacionBasicaDetalle.where("matriculacion_detalle_id = ?",params[:matriculacion_detalle_id]).first	
  					if matriculacion_basica_detalle.present?
  						@response = AsistenciaBasica.where("matriculacion_basica_detalle_id = ? and asistencia = ?",matriculacion_basica_detalle.id, false)
  					end
  					
  					matriculacion_inclusiva_detalle = MatriculacionInclusivaDetalle.where("matriculacion_detalle_id = ?",params[:matriculacion_detalle_id]).first	
  					if matriculacion_inclusiva_detalle.present?
  						@response = AsistenciaInclusiva.where("matriculacion_inclusiva_detalle_id = ? and asistencia = ?",matriculacion_inclusiva_detalle.id, false)
  					end

				end

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	