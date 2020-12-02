module Api

    module V1

		class WebServiceControlGanadoController < ApplicationController
      
			protect_from_forgery with: :null_session
			respond_to :json, only: [:create]
     

  			def create

          control_ganado_ultimo = ControlGanado.last

          if params[:clasificacion_control_ganado_id] == PARAMETRO[:clasificacion_por_ganado]

            control_ganado = ControlGanado.new
            control_ganado.fecha_control = params[:fecha_control]
            control_ganado.ganado_id = params[:ganado_id]
            control_ganado.control_id = params[:control_id]
            control_ganado.medicamento_id = params[:medicamento_id]
            control_ganado.clasificacion_control_id = params[:clasificacion_control_ganado_id]
            control_ganado.codigo = control_ganado_ultimo.codigo + 1
            control_ganado.cantidad_suministrada = params[:cantidad_suministro]
            control_ganado.observacion = "CONTROL DESDE APP"

            if control_ganado.save
          
              response = []
              response = {msg: "exito"}

            end

          end
				
				respond_to do |f|

			      f.json { render :json => response.to_json}

			    end

			 end

		end

	end

end	