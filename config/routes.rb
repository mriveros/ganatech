Rails.application.routes.draw do


  namespace 'api' do
    namespace 'v1' do

      resources :personas
      resources :usuarios

    end
  end
  
  #WEB SERVICES 
  namespace :api, defaults: { format: "json" } do
  
    namespace :v1 do
  
      resources :web_service_user
      post '/api/v1/web_service_user/index'
      
      resources :web_service_recovery
      post '/api/v1/web_service_recovery/index'

      resources :web_service_ganado
      get '/api/v1/web_service_ganado/index'

      resources :web_service_medicamento
      get '/api/v1/web_service_medicamento/index'

      resources :web_service_alimento
      get '/api/v1/web_service_alimento/index'

      resources :web_service_hacienda
      get '/api/v1/web_service_hacienda/index'

      resources :web_service_potrero
      get '/api/v1/web_service_potrero/index'

      resources :web_service_control_ganado
      post '/api/v1/web_service_control_ganado/index'


    end
  
  end


#-------------------------BLOQUE TAREAS AUTOMATICAS------------------------
#CRONTAB
get 'crontab_ultron/index'
#--------------------------------------------------------------------------

#----------------------------INICIO BLOQUE DE RUTAS GANATEC-----------------------

#GANADOS FAENAS
  get 'ganados_faenas/index'
  post 'ganados_faenas/lista'
  get 'ganados_faenas/lista'
  get 'ganados_faenas/agregar'
  post 'ganados_faenas/guardar'
  get 'ganados_faenas/eliminar_ganado_faena'
  get 'ganados_faenas/crear_lote_ganado'
  post 'ganados_faenas/crear_lote_ganado'
  post 'ganados_faenas/lista_ganado'
  get 'ganados_faenas/lista_ganado'
  get 'ganados_faenas/agregar_ganado_lote'
  get 'ganados_faenas/eliminar_ganado_lote'
  get 'ganados_faenas/seleccionar_lote'
  post 'ganados_faenas/eliminar_lote'
  get 'ganados_faenas/buscar_cliente'
  get 'ganados_faenas/buscar_ganado'
  get 'ganados_faenas/ganado_faena_detalle'

#INFO GASTOS
  get 'info_gastos/index'
  post 'info_gastos/lista'
  get 'info_gastos/lista'
  get 'info_gastos/exportar_pdf'

#INFO COMPRAS
  get 'info_compras/index'
  post 'info_compras/lista'
  get 'info_compras/lista'
  get 'info_compras/exportar_pdf'
  post 'info_compras/exportar_pdf'

#INFO VENTAS
  get 'info_ventas/index'
  post 'info_ventas/lista'
  get 'info_ventas/lista'
  get 'info_ventas/exportar_pdf'

#GANADOS MUERTOS
  get 'ganados_muertos/index'
  post 'ganados_muertos/lista'
  get 'ganados_muertos/lista'
  get 'ganados_muertos/exportar_pdf'
  
#CARGOS
  post 'cargos/lista'
  get 'cargos/lista'
  get 'cargos/agregar'
  post 'cargos/guardar'
  get 'cargos/eliminar'
  get 'cargos/editar'
  post 'cargos/actualizar'
  get 'cargos/index'

#REMUNERACIONES EXTRAS
  post 'pagos_remuneraciones_extras/lista'
  get 'pagos_remuneraciones_extras/lista'
  get 'pagos_remuneraciones_extras/agregar'
  post 'pagos_remuneraciones_extras/guardar'
  get 'pagos_remuneraciones_extras/eliminar'
  get 'pagos_remuneraciones_extras/editar'
  post 'pagos_remuneraciones_extras/actualizar'
  get 'pagos_remuneraciones_extras/index'

#DESCUENTOS
  post 'pagos_descuentos/lista'
  get 'pagos_descuentos/lista'
  get 'pagos_descuentos/agregar'
  post 'pagos_descuentos/guardar'
  get 'pagos_descuentos/eliminar'
  get 'pagos_descuentos/editar'
  post 'pagos_descuentos/actualizar'
  get 'pagos_descuentos/index'

#ADELANTOS
  post 'pagos_adelantos/lista'
  get 'pagos_adelantos/lista'
  get 'pagos_adelantos/agregar'
  post 'pagos_adelantos/guardar'
  get 'pagos_adelantos/eliminar'
  get 'pagos_adelantos/editar'
  post 'pagos_adelantos/actualizar'
  get 'pagos_adelantos/index'

#PAGOS DE SALARIOS
  get 'pagos_salarios/index'
  post 'pagos_salarios/lista'
  get 'pagos_salarios/lista'
  get 'pagos_salarios/agregar'
  post 'pagos_salarios/guardar'
  get 'pagos_salarios/eliminar'
  get 'pagos_salarios/salario_detalle'
  
  #MATERIALES
  get 'materiales/index'
  post 'materiales/lista'
  get 'materiales/lista'
  get 'materiales/agregar'
  post 'materiales/guardar'
  get 'materiales/editar'
  post 'materiales/actualizar'
  get 'materiales/eliminar'
  get 'materiales/buscar_material'
  get 'materiales/material_detalle'
  get 'materiales/agregar_material_detalle'
  post 'materiales/guardar_material_detalle'
  get 'materiales/eliminar_material_detalle'


  #TRABAJOS
  get 'trabajos/index'
  post 'trabajos/lista'
  get 'trabajos/lista'
  get 'trabajos/agregar'
  post 'trabajos/guardar'
  get 'trabajos/editar'
  post 'trabajos/actualizar'
  get 'trabajos/eliminar'


  #ORDENES TRABAJOS
  get 'ordenes_trabajos/index'
  post 'ordenes_trabajos/lista'
  get 'ordenes_trabajos/lista'
  get 'ordenes_trabajos/agregar'
  post 'ordenes_trabajos/guardar'
  get 'ordenes_trabajos/editar'
  post 'ordenes_trabajos/actualizar'
  get 'ordenes_trabajos/eliminar'
  get 'ordenes_trabajos/trabajos_detalles'
  get 'ordenes_trabajos/agregar_material_trabajo'
  post 'ordenes_trabajos/guardar_material_trabajo'
  get 'ordenes_trabajos/eliminar_material_trabajo'


#REGISTROS DE GASTOS
  post 'registros_gastos/lista'
  get 'registros_gastos/lista'
  get 'registros_gastos/agregar'
  post 'registros_gastos/guardar'
  get 'registros_gastos/eliminar'
  get 'registros_gastos/editar'
  post 'registros_gastos/actualizar'
  get 'registros_gastos/index'
  

#PERSONALES
  post 'personales/lista'
  get 'personales/lista'
  get 'personales/agregar'
  post 'personales/guardar'
  get 'personales/eliminar'
  get 'personales/editar'
  post 'personales/actualizar'
  get 'personales/index'
  get 'personales/buscar_personal'

  #RAZAS
  get 'razas/index'
  post 'razas/lista'
  get 'razas/lista'
  get 'razas/agregar'
  post 'razas/guardar'
  get 'razas/editar'
  post 'razas/actualizar'
  get 'razas/eliminar'
  get 'razas/buscar_raza'

  #HACIENDAS
  get 'haciendas/index'
  post 'haciendas/lista'
  get 'haciendas/lista'
  get 'haciendas/agregar'
  post 'haciendas/guardar'
  get 'haciendas/editar'
  post 'haciendas/actualizar'
  get 'haciendas/eliminar'
  get 'haciendas/buscar_jurisdiccion'
  get 'haciendas/haciendas_detalles'
  get 'haciendas/agregar_hacienda_detalle'
  post 'haciendas/guardar_hacienda_detalle'
  get 'haciendas/eliminar_hacienda_detalle'
  get 'haciendas/obtener_potreros'

  #POTREROS
  get 'potreros/index'
  post 'potreros/lista'
  get 'potreros/lista'
  get 'potreros/agregar'
  post 'potreros/guardar'
  get 'potreros/editar'
  post 'potreros/actualizar'
  get 'potreros/eliminar'
  get 'potreros/potrero_detalle'
  get 'potreros/agregar_potrero_detalle'
  post 'potreros/guardar_potrero_detalle'
  get 'potreros/eliminar_potrero_detalle'
  
  #GANADOS
  get 'ganados/index'
  post 'ganados/lista'
  get 'ganados/lista'
  get 'ganados/agregar'
  post 'ganados/guardar'
  get 'ganados/editar'
  post 'ganados/actualizar'
  get 'ganados/eliminar'
  get 'ganados/ganado_detalle'
  get 'ganados/obtener_etapa_ganado'
  get 'ganados/buscar_rp_padre'
  get 'ganados/buscar_rp_madre'
  get 'ganados/agregar_control_sanitario'
  post 'ganados/guardar_control_sanitario'
  get 'ganados/eliminar_control_sanitario'
  get 'ganados/agregar_control_alimentacion'
  post 'ganados/guardar_control_alimentacion'
  get 'ganados/eliminar_control_alimentacion'
  get 'ganados/adjuntar_archivo'
  post 'ganados/guardar_archivo_adjunto'
  get 'ganados/agregar_celo'
  post 'ganados/guardar_celo'
  get 'ganados/buscar_ganado'
  get 'ganados/agregar_lote_ganado'
  post 'ganados/guardar_lote_ganado'
  get 'ganados/marcar_con_enfermedad'
  post 'ganados/guardar_ganado_enfermedad'
  get 'ganados/marcar_como_muerto'
  post 'ganados/guardar_ganado_muerto'
  get 'ganados/marcar_como_produccion'


  #MEDICAMENTOS
  get 'medicamentos/index'
  post 'medicamentos/lista'
  get 'medicamentos/lista'
  get 'medicamentos/agregar'
  post 'medicamentos/guardar'
  get 'medicamentos/editar'
  post 'medicamentos/actualizar'
  get 'medicamentos/eliminar'
  get 'medicamentos/buscar_medicamento'
  get 'medicamentos/medicamento_detalle'
  get 'medicamentos/agregar_medicamento_detalle'
  post 'medicamentos/guardar_medicamento_detalle'
  get 'medicamentos/eliminar_medicamento_detalle'
  get 'medicamentos/dar_baja_medicamento'
  post 'medicamentos/guardar_baja_medicamento'

  #ALIMENTOS
  get 'alimentaciones/index'
  post 'alimentaciones/lista'
  get 'alimentaciones/lista'
  get 'alimentaciones/agregar'
  post 'alimentaciones/guardar'
  get 'alimentaciones/editar'
  post 'alimentaciones/actualizar'
  get 'alimentaciones/eliminar'
  get 'alimentaciones/buscar_alimentacion'
  get 'alimentaciones/alimentacion_detalle'
  get 'alimentaciones/agregar_alimentacion_detalle'
  post 'alimentaciones/guardar_alimentacion_detalle'
  get 'alimentaciones/eliminar_alimentacion_detalle'

  #CELOS
  get 'celos/index'
  post 'celos/lista'
  get 'celos/lista'
  get 'celos/agregar'
  post 'celos/guardar'
  get 'celos/editar'
  post 'celos/actualizar'
  get 'celos/eliminar'
  get 'celos/celos_detalles'
  get 'celos/cambiar_estado_a_en_proceso_fecundacion'
  get 'celos/cambiar_estado_a_en_reproduccion'
  get 'celos/cambiar_estado_a_celo_perdido'
  post 'celos/guardar_cambiar_estado_a_en_proceso_fecundacion'
  post 'celos/guardar_cambiar_estado_a_en_reproduccion'
  post 'celos/guardar_cambiar_estado_a_celo_perdido'
  get 'celos/buscar_ganado_reproductor'
  get 'celos/buscar_esperma_reproductor'

  #REPRODUCCIONES
  get 'reproducciones/index'
  post 'reproducciones/lista'
  get 'reproducciones/lista'
  get 'reproducciones/agregar'
  post 'reproducciones/guardar'
  get 'reproducciones/eliminar'
  get 'reproducciones/reproducciones_detalles'
  get 'reproducciones/cambiar_estado_reproduccion'
  get 'reproducciones/cambiar_estado_reproduccion_a_reproduccion_perdido'
  post 'reproducciones/guardar_estado_reproduccion_a_reproduccion_perdido'
  get 'reproducciones/cambiar_estado_reproduccion_a_reproduccion_finalizada'
  post 'reproducciones/guardar_estado_reproduccion_a_reproduccion_finalizada'
  get 'reproducciones/buscar_ganado_reproductor'
  get 'reproducciones/buscar_esperma_reproductor'
  get 'reproducciones/buscar_ganado_estado_celo'


  #ESTADOS GANADOS
  get 'estados_ganados/index'
  post 'estados_ganados/lista'
  get 'estados_ganados/lista'
  get 'estados_ganados/agregar'
  post 'estados_ganados/guardar'
  get 'estados_ganados/editar'
  post 'estados_ganados/actualizar'
  get 'estados_ganados/eliminar'
  get 'estados_ganados/buscar_estado_ganado'

  #EMPRESAS TRANSPORTES
  get 'empresas_transportes/index'
  post 'empresas_transportes/lista'
  get 'empresas_transportes/lista'
  get 'empresas_transportes/agregar'
  post 'empresas_transportes/guardar'
  get 'empresas_transportes/editar'
  post 'empresas_transportes/actualizar'
  get 'empresas_transportes/eliminar'
  get 'empresas_transportes/buscar_empresa_transporte'

  #PROVEEDORES GANADOS
  get 'proveedores_ganados/index'
  post 'proveedores_ganados/lista'
  get 'proveedores_ganados/lista'
  get 'proveedores_ganados/agregar'
  post 'proveedores_ganados/guardar'
  get 'proveedores_ganados/editar'
  post 'proveedores_ganados/actualizar'
  get 'proveedores_ganados/eliminar'
  get 'proveedores_ganados/buscar_proveedor_ganado'

  #ESPERMAS
  get 'espermas/index'
  post 'espermas/lista'
  get 'espermas/lista'
  get 'espermas/agregar'
  post 'espermas/guardar'
  get 'espermas/editar'
  post 'espermas/actualizar'
  get 'espermas/eliminar'
  get 'espermas/esperma_detalle'
  get 'espermas/buscar_ganado'
  get 'espermas/adjuntar_archivo_reproductor'
  post 'espermas/guardar_archivo_adjunto'

  #CONTROLES GANADOS
  get 'controles_ganados/index'
  post 'controles_ganados/lista'
  get 'controles_ganados/lista'
  get 'controles_ganados/agregar'
  post 'controles_ganados/guardar'
  get 'controles_ganados/editar'
  post 'controles_ganados/actualizar'
  get 'controles_ganados/eliminar'
  get 'controles_ganados/buscar_ganado'
  get 'controles_ganados/crear_lote_ganado'
  post 'controles_ganados/crear_lote_ganado'
  post 'controles_ganados/lista_ganado'
  get 'controles_ganados/lista_ganado'
  get 'controles_ganados/agregar_ganado_lote'
  get 'controles_ganados/eliminar_ganado_lote'
  get 'controles_ganados/seleccionar_lote'
  post 'controles_ganados/eliminar_lote'
  get 'controles_ganados/obtener_resumen_control_ganado'
  get 'controles_ganados/imprimir_resumen_control_ganado'
  post 'controles_ganados/imprimir_resumen'
  

  #CONTROLES ALIMENTACIONES
  get 'controles_alimentaciones/index'
  post 'controles_alimentaciones/lista'
  get 'controles_alimentaciones/lista'
  get 'controles_alimentaciones/agregar'
  post 'controles_alimentaciones/guardar'
  get 'controles_alimentaciones/editar'
  post 'controles_alimentaciones/actualizar'
  get 'controles_alimentaciones/eliminar'
  get 'controles_alimentaciones/buscar_ganado'
  get 'controles_alimentaciones/crear_lote_ganado'
  post 'controles_alimentaciones/crear_lote_ganado'
  post 'controles_alimentaciones/lista_ganado'
  get 'controles_alimentaciones/lista_ganado'
  get 'controles_alimentaciones/agregar_ganado_lote'
  get 'controles_alimentaciones/eliminar_ganado_lote'
  get 'controles_alimentaciones/seleccionar_lote'
  post 'controles_alimentaciones/eliminar_lote'


  #GANADOS ENTRADAS
  get 'ganados_entradas/index'
  post 'ganados_entradas/lista'
  get 'ganados_entradas/lista'
  get 'ganados_entradas/agregar_entrada_ganado'
  post 'ganados_entradas/guardar_entrada_ganado'
  get 'ganados_entradas/eliminar_entrada_ganado'
  get 'ganados_entradas/buscar_proveedor'
  get 'ganados_entradas/editar_entrada_ganado'
  post 'ganados_entradas/actualizar_entrada_ganado'
  get 'ganados_entradas/cambiar_estado_entrada_ganado_a_finalizado'
  post 'ganados_entradas/guardar_estado_entrada_ganado_a_finalizado'

  #GANADOS SALIDAS
  get 'ganados_salidas/index'
  post 'ganados_salidas/lista'
  get 'ganados_salidas/lista'
  get 'ganados_salidas/agregar'
  post 'ganados_salidas/guardar'
  get 'ganados_salidas/editar'
  post 'ganados_salidas/actualizar'
  get 'ganados_salidas/eliminar_salida_ganado'
  get 'ganados_salidas/buscar_ganado'
  get 'ganados_salidas/crear_lote_ganado'
  post 'ganados_salidas/crear_lote_ganado'
  post 'ganados_salidas/lista_ganado'
  get 'ganados_salidas/lista_ganado'
  get 'ganados_salidas/agregar_ganado_lote'
  get 'ganados_salidas/eliminar_ganado_lote'
  get 'ganados_salidas/seleccionar_lote'
  post 'ganados_salidas/eliminar_lote'
  get 'ganados_salidas/buscar_cliente'
  get 'ganados_salidas/cambiar_estado_salida_a_finalizado'
  get 'ganados_salidas/seleccionar_lote_a_finalizar'
  post 'ganados_salidas/finalizar_lote_ganado'

  #GANADOS ENFERMOS
  get 'ganados_enfermos/index'
  post 'ganados_enfermos/lista'
  get 'ganados_enfermos/lista'
  get 'ganados_enfermos/eliminar'
  get 'ganados_enfermos/ganado_enfermo_detalle'
  get 'ganados_enfermos/agregar_control_sanitario'
  post 'ganados_enfermos/guardar_control_sanitario'
  get 'ganados_enfermos/eliminar_control_sanitario'
  get 'ganados_enfermos/editar_ganado_enfermo'
  post 'ganados_enfermos/actualizar_ganado_enfermo'
  get 'ganados_enfermos/cambiar_estado_a_recuperado'
  get 'ganados_enfermos/cambiar_estado_a_muerto'
  post 'ganados_enfermos/guardar_estado_ganado_muerto'
  get 'ganados_enfermos/adjuntar_archivo'
  post 'ganados_enfermos/guardar_archivo_adjunto'

  #ALTAS PRODUCCIONES
  get 'altas_producciones/index'
  post 'altas_producciones/lista'
  get 'altas_producciones/lista'
  get 'altas_producciones/alta_produccion_detalle'
  get 'altas_producciones/agregar_alta_produccion_detalle'
  post 'altas_producciones/guardar_alta_produccion_detalle'
  get 'altas_producciones/eliminar_alta_produccion_detalle'
  get 'altas_producciones/marcar_desactivado'
  get 'altas_producciones/agregar_produccion_lote'
  get 'altas_producciones/eliminar_produccion_lote'
  get 'altas_producciones/verificar_tabla_temporal'
  get 'altas_producciones/agregar_alta_produccion_queso'
  post 'altas_producciones/guardar_alta_produccion_queso'
  get 'altas_producciones/enviar_a_derivados_lacteos'

  #ALTAS PRODUCCIONES
  get 'altas_producciones_quesos/index'
  post 'altas_producciones_quesos/lista'
  get 'altas_producciones_quesos/lista'
  get 'altas_producciones_quesos/alta_produccion_queso_detalle'
  get 'altas_producciones_quesos/enviar_a_derivados_lacteos'
  get 'altas_producciones_quesos/eliminar'

  #DERIVADOS LACTEOS
  get 'derivados_lacteos/index'
  post 'derivados_lacteos/lista'
  get 'derivados_lacteos/lista'
  get 'derivados_lacteos/derivado_lacteo_detalle'
  get 'derivados_lacteos/agregar_salida_derivado_lacteo'
  post 'derivados_lacteos/guardar_salida_derivado_lacteo'
  get 'derivados_lacteos/eliminar_salida_derivado_lacteo'

  #VENTAS DERIVADOS
  get 'ventas_derivados/index'
  post 'ventas_derivados/lista'
  get 'ventas_derivados/lista'
  get 'ventas_derivados/derivado_lacteo_detalle'
  get 'ventas_derivados/agregar_salida_derivado_lacteo'
  post 'ventas_derivados/guardar_salida_derivado_lacteo'
  get 'ventas_derivados/eliminar_salida_derivado_lacteo'


#----------------------------FIN BLOQUE DE RUTAS GANATEC----------------------------


#----------------------------INICIO EJEMPLOS DE FONOWARE----------------------------

  #PRECIOS
  post 'precios/lista'
  get 'precios/lista'
  get 'precios/agregar'
  post 'precios/guardar'
  get 'precios/eliminar'
  get 'precios/editar'
  post 'precios/actualizar'
  get 'precios/index'
  get 'precios/obtener_datos'
  get 'precios/buscar_precio'
  get 'precios/marcar_predeterminado'

  #JURISDICCIONES
  get 'jurisdicciones/index'
  get 'jurisdicciones/buscar_juridisccion_oferta'

  #JURISDICCIONES
  get 'informes/index'
  get 'informes/indexa'
  get 'informes/generar_pdf'

   #INFORMACIONES
  get 'informaciones/index'
  get 'informaciones/lista'
  post 'informaciones/lista'
  get 'informaciones/perfiles'
  get 'informaciones/enlaces'
  get 'informaciones/agregar'
  post 'informaciones/guardar'
  get 'informaciones/agregar_enlace'
  get 'informaciones/guardar_enlace'
  post 'informaciones/guardar_enlace'
  get 'informaciones/agregar_perfil'
  get 'informaciones/guardar_perfil'
  get 'informaciones/eliminar'
  get 'informaciones/editar'
  post 'informaciones/actualizar'
  get 'informaciones/editar_enlace'
  post 'informaciones/actualizar_enlace'
  get 'informaciones/eliminar_enlace'
  get 'informaciones/eliminar_rol'

  #DETALLES DEBITOS
  post 'detalles_debitos/lista'
  get 'detalles_debitos/lista'
  get 'detalles_debitos/agregar'
  post 'detalles_debitos/guardar'
  get 'detalles_debitos/eliminar'
  get 'detalles_debitos/editar'
  post 'detalles_debitos/actualizar'
  get 'detalles_debitos/index'

  #DETALLES CREDITOS
  post 'detalles_creditos/lista'
  get 'detalles_creditos/lista'
  get 'detalles_creditos/agregar'
  post 'detalles_creditos/guardar'
  get 'detalles_creditos/eliminar'
  get 'detalles_creditos/editar'
  post 'detalles_creditos/actualizar'
  get 'detalles_creditos/index'


  #CLIENTES
  post 'clientes/lista'
  get 'clientes/lista'
  get 'clientes/agregar'
  post 'clientes/guardar'
  get 'clientes/eliminar'
  get 'clientes/editar'
  post 'clientes/actualizar'
  get 'clientes/index'
  get 'clientes/buscar_cliente'

#----------------------------FIN EJEMPLOS DE FONOWARE---------------------------------



#-----------------------INICIO BLOQUE DE RUTAS KERNEL DEL SISTEMA(NO TOCAR)---------------


  #PERSONAS
  post 'personas/lista'
  get 'personas/lista'
  get 'personas/agregar'
  get 'personas/agregar_persona_senatics'
  post 'personas/guardar'
  post 'personas/guardar_persona_senatics'
  get 'personas/eliminar'
  get 'personas/editar'
  post 'personas/actualizar'
  get 'personas/index'
  get 'personas/mostrar_formulario'
  post 'personas/unificar_persona'
  get 'personas/obtener_datos'
  get 'personas/buscar_persona_senatics'
  get 'personas/buscar_chofer'

  #ROLES
  post 'roles/lista'
  get 'roles/lista'
  get 'roles/agregar'
  post 'roles/guardar'
  get 'roles/eliminar'
  get 'roles/editar'
  post 'roles/actualizar'
  get 'roles/accesos'
  get 'roles/agregar_acceso'
  get 'roles/guardar_acceso'
  get 'roles/eliminar_acceso'
  get 'roles/index'

  #CONTROLADORES
  post 'controladores/lista'
  get 'controladores/lista'
  get 'controladores/agregar'
  post 'controladores/guardar'
  get 'controladores/eliminar'
  get 'controladores/editar'
  post 'controladores/actualizar'
  get 'controladores/acciones'
  get 'controladores/agregar_accion'
  post 'controladores/guardar_accion'
  get 'controladores/eliminar_accion'
  get 'controladores/index'

  #Usuarios
  get 'usuarios/cambiar_perfil_actual'
  get 'usuarios/mi_cuenta'
  post 'usuarios/actualizar_mi_cuenta'
  post 'usuarios/actualizar_mi_password'
  get 'usuarios/perfiles'
  get 'usuarios/agregar_perfil'
  get 'usuarios/guardar_perfil'
  get 'usuarios/eliminar_perfil'
  post 'usuarios/actualizar_password'
  get 'usuarios/reset_password'
  get 'usuarios/perfiles'
  get 'usuarios/index'
  get 'usuarios/lista'
  post 'usuarios/lista'
  get 'usuarios/agregar'
  post 'usuarios/guardar'
  get 'usuarios/eliminar'
  get 'usuarios/editar'
  post 'usuarios/actualizar'
  get 'usuarios/buscar_persona'
  post 'usuarios/cambiar_estado_usuario'

  #Login
  get 'login' => 'usuarios_sessions#new',      :as => :login
  get 'logout' => 'usuarios_sessions#destroy', :as => :logout
  post 'usuarios_sessions/create'
  get 'usuarios_sessions/acceso_denegado'
  get 'usuarios_sessions/new'
  get 'usuarios_sessions/mantenimiento'

  get 'principal/buscar_institucion'
  get 'principal/buscar_persona'
  get 'principal/buscar_usuario'
  post 'principal/guardar_recuperar_password'
  get 'principal/recuperar_password'
  post 'principal/guardar_usuario'
  get 'principal/activar_cuenta'
  get 'principal/agregar_usuario'
  get 'contactos' => 'principal#contactos', :as => :contactos
  get 'index' => 'principal#index', :as => :index
  get 'about' => 'principal#about', :as => :about
  get 'legal' => 'principal#legal', :as => :legal
  get 'index' => 'principal#index', :as => :indexv

  root 'principal#index'

  get 'application/autocompletar' => 'application#autocompletar', :as => :autocompletar

 #------------------------------------------------------------

end
