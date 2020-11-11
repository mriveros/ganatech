module Api

    module V1

		class WebServiceAsistenciaController < ApplicationController
      
			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]
     

  			def create
        
          if params[:matriculacion_detalle_id].present?

            matriculacion_media_detalle = MatriculacionMediaDetalle.where("matriculacion_detalle_id = ?", params[:matriculacion_detalle_id]).first
            
            if matriculacion_media_detalle.present?
              puts "Asistencia de matriculacion media"
              asistencia_media = AsistenciaMedia.where("matriculacion_media_detalle_id = ? and fecha_asistencia = ?",matriculacion_media_detalle.id, Date.today ).first
              if asistencia_media.present?

                asistencia_media.asistencia = params[:estado_asistencia]
              
                if asistencia_media.save
                
                  response = []
                  response = {msg: "exito"}

                end

              else

                puts "Asistencia de matriculacion media"
                asistencia_media = AsistenciaMedia.new
                asistencia_media.matriculacion_media_detalle_id = matriculacion_media_detalle.id
                asistencia_media.asistencia = params[:estado_asistencia]
                asistencia_media.fecha_asistencia = Time.now
                asistencia_media.justificacion = false
                asistencia_media.observacion = "Datos desde MEC-APP"
                asistencia_media.latitud = params[:latitud]
                asistencia_media.longitud = params[:longitud]
                if asistencia_media.save
                    
                  puts "Asistencia Guardada"
                  response = {msg: "exito"}

                end
              
              end

            end

            matriculacion_basica_detalle = MatriculacionBasicaDetalle.where("matriculacion_detalle_id = ?", params[:matriculacion_detalle_id]).first
            if matriculacion_basica_detalle.present?
              puts "Asistencia de matriculacion basica"
              asistencia_basica = AsistenciaBasica.where("matriculacion_basica_detalle_id = ? and fecha_asistencia = ?",matriculacion_basica_detalle.id, Date.today ).first
              if asistencia_basica.present?
                asistencia_basica.asistencia = params[:estado_asistencia]
                
                if asistencia_basica.save
                
                  response = []
                  response = {msg: "exito"}

                end

              else

                puts "Asistencia de matriculacion basica"
                asistencia_basica = AsistenciaBasica.new
                asistencia_basica.matriculacion_basica_detalle_id = matriculacion_basica_detalle.id
                asistencia_basica.asistencia = params[:estado_asistencia]
                asistencia_basica.fecha_asistencia = Time.now
                asistencia_basica.justificacion = false
                asistencia_basica.observacion = "Datos desde MEC-APP"
                asistencia_basica.latitud = params[:latitud]
                asistencia_basica.longitud = params[:longitud]
                if asistencia_basica.save
                    
                  puts "Asistencia Guardada"
                  response = {msg: "exito"}

                end

              end  

            end

            matriculacion_inclusiva_detalle = MatriculacionInclusivaDetalle.where("matriculacion_detalle_id = ?", params[:matriculacion_detalle_id]).first
            if matriculacion_inclusiva_detalle.present?
              puts "Asistencia de matriculacion inclusiva"
              asistencia_inclusiva = AsistenciaInclusiva.where("matriculacion_inclusiva_detalle_id = ? and fecha_asistencia = ?",matriculacion_inclusiva_detalle.id, Date.today ).first
              if asistencia_inclusiva.present?
                asistencia_inclusiva.asistencia = params[:estado_asistencia]
                if asistencia_inclusiva.save
                  
                  response = []
                  response = {msg: "exito"}

                end
              else

                puts "Asistencia de matriculacion inclusiva"
                asistencia_inclusiva = AsistenciaInclusiva.new
                asistencia_inclusiva.matriculacion_inclusiva_detalle_id = matriculacion_inclusiva_detalle.id
                asistencia_inclusiva.asistencia = params[:estado_asistencia]
                asistencia_inclusiva.fecha_asistencia = Time.now
                asistencia_inclusiva.justificacion = false
                asistencia_inclusiva.observacion = "Datos desde MEC-APP"
                asistencia_inclusiva.latitud = params[:latitud]
                asistencia_inclusiva.longitud = params[:longitud]
                if asistencia_inclusiva.save
                    
                  puts "Asistencia Guardada"
                  response = {msg: "exito"}
                end

              end

            end
  				

  			

				end
				respond_to do |f|

			      f.json { render :json => response.to_json}

			    end

			  end

		end

	end

end	