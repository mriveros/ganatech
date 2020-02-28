class Seccion < ActiveRecord::Base

  self.table_name="secciones"

  attr_accessible :seccion_letra, :oferta_educativa_id, :curso_id, :estado_id, :turno_id, :carrera_institucion_id, :especialidad_id

  #validates :oferta_educativa_id, uniqueness: { scope: [ :seccion_letra, :curso_id, :turno_id, :especialidad_id ] }

  def self.eliminar_registros_duplicados

    secciones = self.select("seccion_letra, oferta_educativa_id, curso_id,turno_id, especialidad_id, count(*)").group("seccion_letra, oferta_educativa_id, curso_id,turno_id, especialidad_id").having("count(*) > 1").order("6 desc,oferta_educativa_id, curso_id,turno_id, especialidad_id")

    if secciones.present?

      secciones.each do |s|

        puts "#{s.seccion_letra} #{s.oferta_educativa_id} #{s.curso_id} #{s.turno_id} #{s.especialidad_id} #{s.count}"

        seccion = self.where("seccion_letra = ? and oferta_educativa_id = ? and curso_id = ? and turno_id = ? and especialidad_id = ? and exists (select * from matriculaciones m where secciones.id = m.seccion_id)", s.seccion_letra, s.oferta_educativa_id, s.curso_id, s.turno_id, s.especialidad_id ).first
        
        secciones2 = self.where("seccion_letra = ? and oferta_educativa_id = ? and curso_id = ? and turno_id = ? and especialidad_id = ? and id <> ?", s.seccion_letra, s.oferta_educativa_id, s.curso_id, s.turno_id, s.especialidad_id, seccion.id)
        
        secciones2.each do |s2|


          #MATRICULACIONES BASICAS
          matriculaciones_basicas = MatriculacionBasica.where("seccion_id = ?", s2.id)

          if matriculaciones_basicas.present?

            matriculacion_basica = MatriculacionBasica.where("seccion_id = ?", seccion.id).first

            matriculaciones_basicas.each_with_index do |mb, i|

              puts "matriculaciones basicas #{i}"

              matriculaciones_basicas_detalles = MatriculacionBasicaDetalle.where("matriculacion_basica_id = ?", mb.id)

              if matriculaciones_basicas_detalles.present?

                matriculaciones_basicas_detalles.each_with_index do |mbd, i|

                  mbd.matriculacion_basica_id = matriculacion_basica.id
                  mbd.save

                  puts "matriculaciones basicas detalles #{i}"

                end

              end

              estudiantes_secciones = EstudianteSeccion.where("matriculacion_basica_id = ?", mb.id)

              if estudiantes_secciones.present?

                estudiantes_secciones.each_with_index do |es, i|

                  es.matriculacion_basica_id = matriculacion_basica.id
                  es.save

                  puts "estudiantes secciones #{i}"

                end

              end

              matriculaciones_detalles_movimientos = MatriculacionDetalleMovimiento.where("matriculacion_id = ?", mb.matriculacion_id)

              if matriculaciones_detalles_movimientos.present?

                matriculaciones_detalles_movimientos.each_with_index do |mdm, i|

                  mdm.matriculacion_id = matriculacion_basica.matriculacion_id
                  mdm.seccion_id = matriculacion_basica.seccion_id
                  mdm.save

                  puts "matriculaciones detalles movimientos #{i}"

                end

              end

              inscripciones_inclusivas = InscripcionInclusiva.where("matriculacion_id = ?", mb.matriculacion_id)

              if inscripciones_inclusivas.present?

                inscripciones_inclusivas.each_with_index do |ii, i|

                  ii.matriculacion_id = matriculacion_basica.matriculacion_id
                  ii.save

                  puts "inscripciones inclusivas #{i}"

                end

              end

              mb.destroy

            end

          end
          #FIN MATRICULACIONES BASICAS

          #MATRICULACIONES MEDIAS
          matriculaciones_medias = MatriculacionMedia.where("seccion_id = ?", s2.id)

          if matriculaciones_medias.present?

            matriculacion_media = MatriculacionMedia.where("seccion_id = ?", seccion.id).first

            matriculaciones_medias.each_with_index do |mm, i|

              puts "matriculaciones medias #{i}"

              matriculaciones_medias_detalles = MatriculacionMediaDetalle.where("matriculacion_media_id = ?", mm.id)

              if matriculaciones_medias_detalles.present?

                matriculaciones_medias_detalles.each_with_index do |mmd, i|

                  mmd.matriculacion_media_id = matriculacion_media.id
                  mmd.save

                  puts "matriculaciones medias detalles #{i}"

                end

              end

              estudiantes_secciones = EstudianteSeccion.where("matriculacion_media_id = ?", mm.id)

              if estudiantes_secciones.present?

                estudiantes_secciones.each_with_index do |es, i|

                  es.matriculacion_media_id = matriculacion_media.id
                  es.save

                  puts "estudiantes secciones #{i}"

                end

              end

              matriculaciones_detalles_movimientos = MatriculacionDetalleMovimiento.where("matriculacion_id = ?", mm.matriculacion_id)

              if matriculaciones_detalles_movimientos.present?

                matriculaciones_detalles_movimientos.each_with_index do |mdm, i|

                  mdm.matriculacion_id = matriculacion_media.matriculacion_id
                  mdm.seccion_id = matriculacion_media.seccion_id
                  mdm.save

                  puts "matriculaciones detalles movimientos #{i}"

                end

              end

              mm.destroy

            end

          end
          #FIN MATRICULACIONES MEDIAS

          #MATRICULACIONES INCLUSIVAS
          matriculaciones_inclusivas = MatriculacionInclusiva.where("seccion_id = ?", s2.id)

          if matriculaciones_inclusivas.present?

            matriculacion_inclusiva = MatriculacionInclusiva.where("seccion_id = ?", seccion.id).first

            matriculaciones_inclusivas.each_with_index do |mi, i|

              puts "matriculaciones inclusivas #{i}"

              matriculaciones_inclusivas_detalles = MatriculacionInclusivaDetalle.where("matriculacion_inclusiva_id = ?", mi.id)

              if matriculaciones_inclusivas_detalles.present?

                matriculaciones_inclusivas_detalles.each_with_index do |mid, i|

                  mid.matriculacion_inclusiva_id = matriculacion_inclusiva.id
                  mid.save

                  puts "matriculaciones inclusivas detalles #{i}"

                end

              end

              estudiantes_secciones = EstudianteSeccion.where("matriculacion_inclusiva_id = ?", mi.id)

              if estudiantes_secciones.present?

                estudiantes_secciones.each_with_index do |es, i|

                  es.matriculacion_inclusiva_id = matriculacion_inclusiva.id
                  es.save

                  puts "estudiantes secciones #{i}"

                end

              end

              matriculaciones_detalles_movimientos = MatriculacionDetalleMovimiento.where("matriculacion_id = ?", mi.matriculacion_id)

              if matriculaciones_detalles_movimientos.present?

                matriculaciones_detalles_movimientos.each_with_index do |mdm, i|

                  mdm.matriculacion_id = matriculacion_inclusiva.matriculacion_id
                  mdm.save

                  puts "matriculaciones detalles movimientos #{i}"

                end

              end

              inscripciones_inclusivas = InscripcionInclusiva.where("matriculacion_id = ?", mi.matriculacion_id)

              if inscripciones_inclusivas.present?

                inscripciones_inclusivas.each_with_index do |ii, i|

                  ii.matriculacion_id = matriculacion_inclusiva.matriculacion_id
                  ii.save

                  puts "inscripciones inclusivas #{i}"

                end

              end

              mi.destroy

            end

          end
          #FIN MATRICULACIONES INCLUSIVAS

          #MATRICULACIONES PERMANENTES
          matriculaciones_permanentes = MatriculacionPermanente.where("seccion_id = ?", s2.id)

          if matriculaciones_permanentes.present?

            matriculacion_permanente = MatriculacionPermanente.where("seccion_id = ?", seccion.id).first

            matriculaciones_permanentes.each_with_index do |mp, i|

              puts "matriculaciones permanentes #{i}"

              matriculaciones_permanentes_detalles = MatriculacionPermanenteDetalle.where("matriculacion_permanente_id = ?", mp.id)

              if matriculaciones_permanentes_detalles.present?

                matriculaciones_permanentes_detalles.each_with_index do |mpd, i|

                  mpd.matriculacion_permanente_id = matriculacion_permanente.id
                  mpd.save

                  puts "matriculaciones permanentes detalles #{i}"

                end

              end

              estudiantes_secciones = EstudianteSeccion.where("matriculacion_permanente_id = ?", mp.id)

              if estudiantes_secciones.present?

                estudiantes_secciones.each_with_index do |es, i|

                  es.matriculacion_permanente_id = matriculacion_permanente.id
                  es.save

                  puts "estudiantes secciones #{i}"

                end

              end

              matriculaciones_detalles_movimientos = MatriculacionDetalleMovimiento.where("matriculacion_id = ?", mp.matriculacion_id)

              if matriculaciones_detalles_movimientos.present?

                matriculaciones_detalles_movimientos.each_with_index do |mdm, i|

                  mdm.matriculacion_id = matriculacion_permanente.matriculacion_id
                  mdm.seccion_id = matriculacion_permanente.seccion_id
                  mdm.save

                  puts "matriculaciones detalles movimientos #{i}"

                end

              end

              mp.destroy

            end

          end
          #FIN MATRICULACIONES PERMANENTES

          if s2.id != seccion.id

            if s2.destroy

              puts "Eliminado seccion #{s2.id}"

            end

          end

        end

      end

    end

  end


end
