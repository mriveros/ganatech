module Api

    module V1
    	
    	#require 'gcm'

		class GcmServerServiceController < ApplicationController

		
		protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

	  		def show

				gcm = GCM.new("AIzaSyAVkWWnbNI8ZbyLqyFI5jPqFpOVSxGdWoI")

				# you can set option parameters in here
				#  - all options are pass to HTTParty method arguments
				#  - ref: https://github.com/jnunemaker/httparty/blob/master/lib/httparty.rb#L29-L60
				#  gcm = GCM.new("my_api_key", timeout: 3)

				registration_ids= ["APA91bHPTcvFhJ9H6WaJ4jVw5vjYMF37Ir2Oq3qzY5MkZLIx92hsByCsAqUoz9wSU_afpchStuov2KENefJ6nnmBYshfYCKXPFFwNOrI1u4wgKJFdWt-JP9IUPAVVHhalBJorDvGBplx "] # an array of one or more client registration tokens
				options = {data: {score: "123"}, collapse_key: "updated_score"}
				response = gcm.send(registration_ids, options)

				respond_to do |f|

			      f.json { render :json => response.to_json}

			    end


			end

		end

	end

end
