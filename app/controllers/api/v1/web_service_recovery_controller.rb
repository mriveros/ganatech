module Api

    module V1

		class WebServiceRecoveryController < ApplicationController
      
			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]
     

  			def create

  				relevamiento = Relevamiento.new
  				relevamiento.usuario_id = params[:cod_usuario]
  				relevamiento.distrito_ciudad = params[:distrito_ciudad]
  				relevamiento.localidad =  params[:localidad]
  				relevamiento.nombre_apellido = params[:nombre_apellido]
  				relevamiento.numero_documento = params[:numero_documento]
  				relevamiento.responsable = params[:responsable]
  				relevamiento.numero_telefono = params[:numero_telefono]
  				relevamiento.direccion = params[:direccion]
  				relevamiento.cantidad_personas = params[:cantidad_personas]
  				relevamiento.ocupacion_encargado = params[:ocupacion_encargado]
  				#aqui seleccionamos el tipo de documento y usamos el parametro
  				relevamiento.tipo_documento_id = params[:tipo_documento]
  				#aqui seleccionamos el tipo de zona y usamos el parametro
  				relevamiento.tipo_zona_id = params[:tipo_zona]
  				#aqui seleccionamos el motivo y utilizamos el parametro
  				relevamiento.motivo_id = params[:tipo_motivo]
  				#aqui seleccionamos la respuesta si tiene o no discpacidad y utilizamos el parametro
  				if params[:tipo_respuesta].to_s == PARAMETRO[:respuesta_si].to_s
	  			
					relevamiento.posee_discapacidad = true

	  			else

	  				relevamiento.posee_discapacidad = false

	  			end
  				relevamiento.vive_con_padre = params[:padre]
  				relevamiento.vive_con_madre = params[:madre]
  				relevamiento.vive_con_hermanos = params[:hermanos]
  				relevamiento.vive_con_esposo_compañero = params[:esposo_compañero]
  				relevamiento.vive_con_hijo = params[:hijo]
  				relevamiento.vive_con_solo = params[:solo]
  				relevamiento.vive_con_otro = params[:otro]
  				relevamiento.ubicacion_latitude = params[:ubicacion_latitude]
  				relevamiento.ubicacion_longitude = params[:ubicacion_longitude]
  				relevamiento.fecha_nacimiento = params[:fecha_nacimiento]
  				relevamiento.motivo_deja_estudio_otro = params[:motivo_deja_estudio_otro]
  				relevamiento.posee_discapacidad_otro = params[:posee_discapacidad_otro]
  				relevamiento.vive_con_otro_especificar = params[:vive_con_otro]

  				#Aca debemos agregar los check de discapacidad recibidos
  				relevamiento.check_dis_1 = params[:check_dis_1]
  				relevamiento.check_dis_2 = params[:check_dis_2]
  				relevamiento.check_dis_3 = params[:check_dis_3]
  				relevamiento.check_dis_4 = params[:check_dis_4]
  				relevamiento.check_dis_5 = params[:check_dis_5]
  				relevamiento.check_dis_6 = params[:check_dis_6]
  				relevamiento.check_dis_7 = params[:check_dis_7]
  				relevamiento.check_dis_8 = params[:check_dis_8]
  				relevamiento.check_dis_9 = params[:check_dis_9]
  				relevamiento.check_dis_10 = params[:check_dis_10]
  				relevamiento.check_dis_11 = params[:check_dis_11]
  				relevamiento.check_dis_12 = params[:check_dis_12]
  				relevamiento.check_dis_13 = params[:check_dis_13]
  				relevamiento.check_dis_14 = params[:check_dis_14]
  				relevamiento.check_dis_15 = params[:check_dis_15]
  				relevamiento.check_dis_16 = params[:check_dis_16]
  				relevamiento.check_dis_17 = params[:check_dis_17]

  				if relevamiento.save
  				
  					response = []
  					response = {msg: "exito"}

  				end
				
				respond_to do |f|

			      f.json { render :json => response.to_json}

			    end

			 end

		end

	end

end	