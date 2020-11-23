module Api

    module V1

		class WebServiceAlimentoController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

			require 'json'

			

  			def show

				@response = VAlimentacion.disponible
				
				json = JSON.parse(@response.to_json)
				json.first.reject! do |key, value|

				  value == ''

				end
				
				puts json.to_s

				respond_to do |f|

			      f.json { render :json => json.to_s}

			   
			    end


			 end

		end

	end

end	