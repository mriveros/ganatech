module Api
    module V1
        class UsuariosController < ApplicationController
        	#protect_from_forgery with: :null_session
        	skip_before_action :verify_authenticity_token
        	def index
			    @usuarios = Usuario.order('created_at DESC')
			    render json: @usuarios
			end

			def create
			    @user = Usuario.new(user_params)
			    if @user.save
			      render status: :created
			    else
			      render json: @user.errors, status: :unprocessable_entity
			    end
			end
			 
			private
			 
			def user_params
			    params.require(:usuarios)
			end

        end
    end
end