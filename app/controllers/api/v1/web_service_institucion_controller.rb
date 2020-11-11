module Api

    module V1

		class WebServiceInstitucionController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show

  				if  params[:usuario_id].present?

  					puts "************************************************IN!!!"
  					@response = SigmecInstitucion.select("codigo_institucion as establecimiento_id,nombre_institucion as establecimiento, codigo_establecimiento ").where("id_persona = ? ",params[:usuario_id])

				end

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	