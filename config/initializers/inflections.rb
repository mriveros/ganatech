# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections do |inflect|
   inflect.plural(/([aeiou])([A-Z]|_|$)/, '\1s\2')
   inflect.plural(/([rlnsd])([A-Z]|_|$)/, '\1es\2')
   inflect.plural(/([aeiou])([A-Z]|_|$)([a-z]+)([rlnd])($)/, '\1s\2\3\4es\5')
   inflect.plural(/([rlnd])([A-Z]|_|$)([a-z]+)([aeiou])($)/, '\1es\2\3\4s\5')
   inflect.singular(/([aeiou])s([A-Z]|_|$)/, '\1\2')
   inflect.singular(/([rlnsd])es([A-Z]|_|$)/, '\1\2')
   inflect.singular(/([aeiou])s([A-Z]|_)([a-z]+)([rlnd])es($)/, '\1\2\3\4\5')
   inflect.singular(/([rlnsd])es([A-Z]|_)([a-z]+)([aeiou])s($)/, '\1\2\3\4\5')
   inflect.irregular 'tipo_documento', 'tipos_documentos'
   inflect.irregular 'nacionalidad', 'nacionalidades'
   inflect.irregular 'catalogo_detalle', 'catalogos_detalles'
   inflect.irregular 'especificacion_detalle', 'especificaciones_detalles'
   inflect.irregular 'solicitud_detalle', 'solicitudes_detalles'
   inflect.irregular 'presupuesto_detalle', 'presupuestos_detalles'
   inflect.irregular 'solicitud_producto_detalle', 'solicitudes_productos_detalles'
   inflect.irregular 'legajo_detalle', 'legajos_detalles'
   inflect.irregular 'paquete_detalle', 'paquetes_detalles'
   inflect.irregular 'persona_contacto', 'personas_contactos'
   inflect.irregular 'modalidad_nivel', 'modalidades_niveles'
   inflect.irregular 'modalidad_nivel_servicio', 'modalidades_niveles_servicios'
   inflect.irregular 'tipo_servicio', 'tipos_servicios'
   inflect.irregular 'usuario_oferta_educativa', 'usuarios_ofertas_educativas'
   inflect.irregular 'estudiante_autorizacion_movimiento', 'estudiantes_autorizaciones_movimientos'
   inflect.irregular 'infraestructura_espacio', 'infraestructuras_espacios'
   inflect.irregular 'infraestructura_fiscalizacion_detalle', 'infraestructuras_fiscalizaciones_detalles'
   inflect.irregular 'infraestructura_detalle_opcion', 'infraestructuras_detalles_opciones'
   inflect.irregular 'v_matriculacion_detalle_v2', 'v_matriculaciones_detalles_v2'
   inflect.irregular 'v_matriculacion_detalle_v4', 'v_matriculaciones_detalles_v4'
   inflect.irregular 'infraestructura_fiscalizacion_adjunto', 'infraestructuras_fiscalizaciones_adjuntos'
   inflect.irregular 'infraestructura_parte', 'infraestructuras_partes'
   inflect.irregular 'matriculacion_detalle_movimiento', 'matriculaciones_detalles_movimientos'
   inflect.irregular 'estado_traslado_estudiante', 'estados_traslados_estudiantes'
   inflect.irregular 'oferta_educativa_autoridad', 'ofertas_educativas_autoridades'
   inflect.irregular 'matriculacion_observacion', 'matriculaciones_observaciones'
   inflect.irregular 'matriculacion_promocion', 'matriculaciones_promociones'
   inflect.irregular 'matriculacion_detalle_documento', 'matriculaciones_detalles_documentos'

end
