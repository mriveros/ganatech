class GraficosController < ApplicationController

	before_filter :require_usuario

  def por_cantidad_matriculados

    usuarios_ofertas_educativas = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", current_usuario.id, PARAMETRO[:rol_director])

    if usuarios_ofertas_educativas.present?

      v_matriculaciones_ids = []
       
      usuarios_ofertas_educativas.each do |uoe|

        oferta_educativa_usuario = OfertaEducativa.where("id = ?", uoe.oferta_educativa_id).first

        if uoe.turno_id.present?

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and turno_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, uoe.turno_id, oferta_educativa_usuario.modalidad_nivel_id)

        else

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, oferta_educativa_usuario.modalidad_nivel_id)

        end

        if matriculaciones_usuarios.present?

          matriculaciones_usuarios.each do |mu|

            v_matriculaciones_ids << mu.matriculacion_id

          end

        end

      end

      if v_matriculaciones_ids.size > 0

        @estadisticas_cantidades = MvEstadisticaAcademicaMatriculacion.select("periodo, codigo_institucion, nombre_institucion, sum(cantidad_matriculados) as cantidad_matriculados, sum(cantidad_logrados) as cantidad_logrados, sum(cantidad_no_logrados) as cantidad_no_logrados").where("matriculacion_id in (?) and codigo_institucion = ? and nombre_institucion = ?", v_matriculaciones_ids, params[:codigo_institucion], params[:nombre_institucion] ).group("periodo, codigo_institucion, nombre_institucion").order("codigo_institucion, nombre_institucion, periodo")


        if @estadisticas_cantidades.present?

          @matriculados_por_anio = []

          codigo_institucion = @estadisticas_cantidades.first.codigo_institucion
          nombre_institucion = @estadisticas_cantidades.first.nombre_institucion
          datos = []
          encabezado = []

          @estadisticas_cantidades.each do |ec|
              
            if codigo_institucion != ec.codigo_institucion && nombre_institucion != ec.nombre_institucion
              
              registro = { codigo_institucion: codigo_institucion, nombre_institucion: nombre_institucion, datos: datos, encabezado: encabezado  }

              codigo_institucion = ec.codigo_institucion
              nombre_institucion = ec.nombre_institucion
            
              @matriculados_por_anio << registro
              datos = []
              encabezado = []

            end

            datos << "{ y: '#{ec.periodo.to_i}', a: #{ec.cantidad_matriculados.to_i} }"
            encabezado << { periodo: ec.periodo.to_i, cantidad_matriculados: ec.cantidad_matriculados.to_i }

          end

          registro = { codigo_institucion: codigo_institucion, nombre_institucion: nombre_institucion, datos: datos, encabezado: encabezado  }
          @matriculados_por_anio << registro

        end

      end

    end

    respond_to do |f|

      f.html

    end

  end

  def reportes_matriculaciones

    usuarios_ofertas_educativas = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", current_usuario.id, PARAMETRO[:rol_director])

    if usuarios_ofertas_educativas.present?

      v_matriculaciones_ids = []
       
      usuarios_ofertas_educativas.each do |uoe|

        oferta_educativa_usuario = OfertaEducativa.where("id = ?", uoe.oferta_educativa_id).first

        if uoe.turno_id.present?

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and turno_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, uoe.turno_id, oferta_educativa_usuario.modalidad_nivel_id)

        else

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, oferta_educativa_usuario.modalidad_nivel_id)

        end

        if matriculaciones_usuarios.present?

          matriculaciones_usuarios.each do |mu|

            v_matriculaciones_ids << mu.matriculacion_id

          end

        end

      end

      if v_matriculaciones_ids.size > 0

        @matriculaciones = MvEstadisticaAcademicaMatriculacion.where("matriculacion_id in (?) and periodo = 2018", v_matriculaciones_ids)

      end

    end


    respond_to do |f|

      f.js

    end

  end

  def por_cantidad_aprobados

    usuarios_ofertas_educativas = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", current_usuario.id, PARAMETRO[:rol_director])

    if usuarios_ofertas_educativas.present?

      v_matriculaciones_ids = []
       
      usuarios_ofertas_educativas.each do |uoe|

        oferta_educativa_usuario = OfertaEducativa.where("id = ?", uoe.oferta_educativa_id).first

        if uoe.turno_id.present?

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and turno_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, uoe.turno_id, oferta_educativa_usuario.modalidad_nivel_id)

        else

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, oferta_educativa_usuario.modalidad_nivel_id)

        end

        if matriculaciones_usuarios.present?

          matriculaciones_usuarios.each do |mu|

            v_matriculaciones_ids << mu.matriculacion_id

          end

        end

      end

      if v_matriculaciones_ids.size > 0

        @estadisticas_cantidades = MvEstadisticaAcademicaMatriculacion.select("periodo, codigo_institucion, nombre_institucion, sum(cantidad_matriculados) as cantidad_matriculados, sum(cantidad_logrados_final) as cantidad_logrados_final, sum(cantidad_no_logrados_final) as cantidad_no_logrados_final, sum(cantidad_logrados_primer_parcial) as cantidad_logrados_primer_parcial, sum(cantidad_no_logrados_primer_parcial) as cantidad_no_logrados_primer_parcial, sum(cantidad_logrados_segundo_parcial) as cantidad_logrados_segundo_parcial, sum(cantidad_no_logrados_segundo_parcial) as cantidad_no_logrados_segundo_parcial").where("matriculacion_id in (?) and periodo = ? and codigo_institucion = ? and nombre_institucion = ?", v_matriculaciones_ids, params[:periodo], params[:codigo_institucion], params[:nombre_institucion] ).group("periodo, codigo_institucion, nombre_institucion").order("codigo_institucion, periodo")

      end

    end

    respond_to do |f|

      f.html

    end

  end

  def por_cantidad_reprobados

    usuarios_ofertas_educativas = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", current_usuario.id, PARAMETRO[:rol_director])

    if usuarios_ofertas_educativas.present?

      v_matriculaciones_ids = []
       
      usuarios_ofertas_educativas.each do |uoe|

        oferta_educativa_usuario = OfertaEducativa.where("id = ?", uoe.oferta_educativa_id).first

        if uoe.turno_id.present?

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and turno_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, uoe.turno_id, oferta_educativa_usuario.modalidad_nivel_id)

        else

          matriculaciones_usuarios = VMatriculacionV3.where("oferta_educativa_id = ? and modalidad_nivel_id = ?", uoe.oferta_educativa_id, oferta_educativa_usuario.modalidad_nivel_id)

        end

        if matriculaciones_usuarios.present?

          matriculaciones_usuarios.each do |mu|

            v_matriculaciones_ids << mu.matriculacion_id

          end

        end

      end

      if v_matriculaciones_ids.size > 0

        @estadisticas_cantidades = MvEstadisticaAcademicaMatriculacion.select("periodo, codigo_institucion, nombre_institucion, sum(cantidad_matriculados) as cantidad_matriculados, sum(cantidad_logrados_final) as cantidad_logrados_final, sum(cantidad_no_logrados_final) as cantidad_no_logrados_final, sum(cantidad_logrados_primer_parcial) as cantidad_logrados_primer_parcial, sum(cantidad_no_logrados_primer_parcial) as cantidad_no_logrados_primer_parcial, sum(cantidad_logrados_segundo_parcial) as cantidad_logrados_segundo_parcial, sum(cantidad_no_logrados_segundo_parcial) as cantidad_no_logrados_segundo_parcial").where("matriculacion_id in (?) and periodo = ? and codigo_institucion = ? and nombre_institucion = ?", v_matriculaciones_ids, params[:periodo], params[:codigo_institucion], params[:nombre_institucion] ).group("periodo, codigo_institucion, nombre_institucion").order("codigo_institucion, periodo")

      end

    end

    respond_to do |f|

      f.html

    end

  end

  def reportes_ofertas_educativas

    usuarios_ofertas_educativas = UsuarioOfertaEducativa.where("usuario_id = ? and rol_id = ? and borrado = false", current_usuario.id, PARAMETRO[:rol_director])

    if usuarios_ofertas_educativas.present?

      @ofertas_educativas = VOfertaEducativa.where("oferta_educativa_id in (?)", usuarios_ofertas_educativas.map(&:oferta_educativa_id))  

    end


    respond_to do |f|

      f.js

    end

  end


end
