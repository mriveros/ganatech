module Api

  module V1

		class WebServiceRescateController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show

  				response = Relevamiento.where("usuario_id = ?", params[:usuario_id])
				
				  respond_to do |f|

			      f.json { render :json => response.to_json}

			    end

			 end

		end

	end

end	