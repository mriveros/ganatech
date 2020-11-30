module Api

    module V1

		class WebServicePotreroController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

			require 'json'

			

  			def show

				@response = VPotrero.orden_01

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end

			 end

		end

	end

end	