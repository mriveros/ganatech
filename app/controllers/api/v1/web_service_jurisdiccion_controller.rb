module Api

    module V1

		class WebServiceJurisdiccionController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show

  				if  params[:departamento_id].present?

  					@response = Jurisdiccion.select("id, departamento_id, descripcion").where("departamento_id = ?", params[:departamento_id])
				
				else

					@response = Jurisdiccion.select("id, departamento_id, descripcion")

				end

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	