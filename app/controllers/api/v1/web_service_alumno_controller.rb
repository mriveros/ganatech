module Api

    module V1

		class WebServiceAlumnoController < ApplicationController

			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]

  			def show
  				@tiene_asistencia_hoy = false
  				if  params[:seccion_id].present?  


  					matriculacion = Matriculacion.where("seccion_id = ? and periodo_desde= 2019 and periodo_hasta= 2019", params[:seccion_id]).first
  					#-------------------desde aca codigo nuevo
            if matriculacion.present?
  					
              matriculacion_detalle = MatriculacionDetalle.where("matriculacion_id = ?", matriculacion.id)
    					
              matriculacion_detalle.each do |md|
                #Matriculacion Media
    						matriculacion_media_detalle = MatriculacionMediaDetalle.where("matriculacion_detalle_id = ?", md.id).first
                if matriculacion_media_detalle.present?

      						asistencia_now = AsistenciaMedia.where("matriculacion_media_detalle_id = ? and fecha_asistencia = ?", matriculacion_media_detalle.id, Date.today).first
      						if asistencia_now.present?
      							@tiene_asistencia_hoy = true
      						end
                end

                #Matriculacion Basica
                matriculacion_basica_detalle = MatriculacionBasicaDetalle.where("matriculacion_detalle_id = ?", md.id).first
                if matriculacion_basica_detalle.present?

                  asistencia_now = AsistenciaBasica.where("matriculacion_basica_detalle_id = ? and fecha_asistencia = ?", matriculacion_basica_detalle.id, Date.today).first
                  if asistencia_now.present?
                    @tiene_asistencia_hoy = true
                  end
                end

                 #Matriculacion Inclusiva
                matriculacion_inclusiva_detalle = MatriculacionInclusivaDetalle.where("matriculacion_detalle_id = ?", md.id).first
                if matriculacion_inclusiva_detalle.present?

                  asistencia_now = AsistenciaBasica.where("matriculacion_inclusiva_detalle_id = ? and fecha_asistencia = ?", matriculacion_inclusiva_detalle.id, Date.today).first
                  if asistencia_now.present?
                    @tiene_asistencia_hoy = true
                  end
                end

    					end

    					if @tiene_asistencia_hoy == true
    						matriculacion_detalle = MatriculacionDetalle.where("matriculacion_id = ?", matriculacion.id).first
                
                #Matriculacion Media
                matriculacion_media_detalle = MatriculacionMediaDetalle.where("matriculacion_detalle_id = ?", matriculacion_detalle.id).first
                if matriculacion_media_detalle.present?
    						  
                  @response = VMatriculacionDetalleV5.select("v_matriculaciones_detalles_v6.matriculacion_detalle_id, v_matriculaciones_detalles_v6.estudiante_id, v_matriculaciones_detalles_v6.estudiante_nombre, v_matriculaciones_detalles_v6.estudiante_apellido , v_matriculaciones_detalles_v6.estudiante_documento, asistencias_medias.asistencia").joins("join matriculaciones_medias_detalles on matriculaciones_medias_detalles.matriculacion_detalle_id = v_matriculaciones_detalles_v6.matriculacion_detalle_id join asistencias_medias on asistencias_medias.matriculacion_media_detalle_id = matriculaciones_medias_detalles.id" ).where("v_matriculaciones_detalles_v6.matriculacion_id = ?  and v_matriculaciones_detalles_v6.estado_matriculacion_id in (3,5) and asistencias_medias.fecha_asistencia = ?",matriculacion.id, Date.today ).ordenado_01

    					  end
               
                #Matriculacion Basica
                matriculacion_basica_detalle = MatriculacionBasicaDetalle.where("matriculacion_detalle_id = ?", matriculacion_detalle.id).first
                if matriculacion_basica_detalle.present?
                  
                  @response = VMatriculacionDetalleV5.select("v_matriculaciones_detalles_v6.matriculacion_detalle_id, v_matriculaciones_detalles_v6.estudiante_id, v_matriculaciones_detalles_v6.estudiante_nombre, v_matriculaciones_detalles_v6.estudiante_apellido , v_matriculaciones_detalles_v6.estudiante_documento, asistencias_basicas.asistencia").joins("join matriculaciones_basicas_detalles on matriculaciones_basicas_detalles.matriculacion_detalle_id = v_matriculaciones_detalles_v6.matriculacion_detalle_id join asistencias_basicas on asistencias_basicas.matriculacion_basica_detalle_id = matriculaciones_basicas_detalles.id" ).where("v_matriculaciones_detalles_v6.matriculacion_id = ?  and v_matriculaciones_detalles_v6.estado_matriculacion_id in (3,5) and asistencias_basicas.fecha_asistencia = ?",matriculacion.id, Date.today ).ordenado_01
                
                end
                 #Matriculacion Inclusiva
                matriculacion_inclusiva_detalle = MatriculacionInclusivaDetalle.where("matriculacion_detalle_id = ?", matriculacion_detalle.id).first
                if matriculacion_inclusiva_detalle.present?
                  
                  @response = VMatriculacionDetalleV5.select("v_matriculaciones_detalles_v6.matriculacion_detalle_id, v_matriculaciones_detalles_v6.estudiante_id, v_matriculaciones_detalles_v6.estudiante_nombre, v_matriculaciones_detalles_v6.estudiante_apellido , v_matriculaciones_detalles_v6.estudiante_documento, asistencias_inclusivas.asistencia").joins("join matriculaciones_inclusivas_detalles on matriculaciones_inclusivas_detalles.matriculacion_detalle_id = v_matriculaciones_detalles_v6.matriculacion_detalle_id join asistencias_inclusivas on asistencias_inclusivas.matriculacion_inclusiva_detalle_id = matriculaciones_inclusivas_detalles.id" ).where("v_matriculaciones_detalles_v6.matriculacion_id = ?  and v_matriculaciones_detalles_v6.estado_matriculacion_id in (3,5) and asistencias_inclusivas.fecha_asistencia = ?",matriculacion.id, Date.today ).ordenado_01
                
                end
              
              else
    						@response = VMatriculacionDetalleV5.select(" matriculacion_detalle_id, estudiante_id, estudiante_nombre, estudiante_apellido , estudiante_documento, true as asistencia").where("matriculacion_id = ?  and estado_matriculacion_id in (3,5)",matriculacion.id ).ordenado_01
    					
    					end

            else

              response = []
              response = {msg: "Sin Datos"}

            end

				end

				respond_to do |f|

			      f.json { render :json => @response.to_json}

			    end


			 end

		end

	end

end	