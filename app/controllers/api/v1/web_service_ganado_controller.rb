module Api

    module V1

		class WebServiceGanadoController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show

				@response = VGanado.modulo_ganados

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	