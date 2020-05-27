Rails.application.routes.draw do


  namespace 'api' do
    namespace 'v1' do

      resources :personas
      resources :usuarios

    end
  end
#-------------------------BLOQUE TAREAS AUTOMATICAS------------------------
#CRONTAB
get "crontab_ultron/index"
#--------------------------------------------------------------------------


#----------------------------INICIO BLOQUE DE RUTAS GANATEC-----------------------
  #RAZAS
  get "razas/index"
  post "razas/lista"
  get "razas/lista"
  get "razas/agregar"
  post "razas/guardar"
  get "razas/editar"
  post "razas/actualizar"
  get "razas/eliminar"
  get "razas/buscar_raza"

  #HACIENDAS
  get "haciendas/index"
  post "haciendas/lista"
  get "haciendas/lista"
  get "haciendas/agregar"
  post "haciendas/guardar"
  get "haciendas/editar"
  post "haciendas/actualizar"
  get "haciendas/eliminar"
  get "haciendas/buscar_jurisdiccion"
  get "haciendas/haciendas_detalles"
  get "haciendas/agregar_hacienda_detalle"
  post "haciendas/guardar_hacienda_detalle"
  get "haciendas/eliminar_hacienda_detalle"
  get "haciendas/obtener_potreros"

  #POTREROS
  get "potreros/index"
  post "potreros/lista"
  get "potreros/lista"
  get "potreros/agregar"
  post "potreros/guardar"
  get "potreros/editar"
  post "potreros/actualizar"
  get "potreros/eliminar"
  get "potreros/potrero_detalle"

  #GANADOS
  get "ganados/index"
  post "ganados/lista"
  get "ganados/lista"
  get "ganados/agregar"
  post "ganados/guardar"
  get "ganados/editar"
  post "ganados/actualizar"
  get "ganados/eliminar"
  get "ganados/ganado_detalle"
  get "ganados/obtener_etapa_ganado"
  get "ganados/buscar_rp_padre"
  get "ganados/buscar_rp_madre"
  get "ganados/agregar_control_sanitario"
  post "ganados/guardar_control_sanitario"
  get "ganados/eliminar_control_sanitario"
  get "ganados/agregar_control_alimentacion"
  post "ganados/guardar_control_alimentacion"
  get "ganados/eliminar_control_alimentacion"
  get "ganados/adjuntar_archivo"
  post "ganados/guardar_archivo_adjunto"
  get "ganados/agregar_celo"
  post "ganados/guardar_celo"
  get "ganados/buscar_ganado"


  #MEDICAMENTOS
  get "medicamentos/index"
  post "medicamentos/lista"
  get "medicamentos/lista"
  get "medicamentos/agregar"
  post "medicamentos/guardar"
  get "medicamentos/editar"
  post "medicamentos/actualizar"
  get "medicamentos/eliminar"
  get "medicamentos/buscar_medicamento"

  #ALIMENTACIONES
  get "alimentaciones/index"
  post "alimentaciones/lista"
  get "alimentaciones/lista"
  get "alimentaciones/agregar"
  post "alimentaciones/guardar"
  get "alimentaciones/editar"
  post "alimentaciones/actualizar"
  get "alimentaciones/eliminar"
  get "alimentaciones/buscar_alimentacion"


  #CELOS
  get "celos/index" 
  post "celos/lista"
  get "celos/lista"
  get "celos/agregar"
  post "celos/guardar"
  get "celos/editar"
  post "celos/actualizar"
  get "celos/eliminar"
  get "celos/celos_detalles"
  get "celos/cambiar_estado_a_en_proceso_fecundacion"
  get "celos/cambiar_estado_a_en_reproduccion"
  get "celos/cambiar_estado_a_celo_perdido"
  post "celos/guardar_cambiar_estado_a_en_proceso_fecundacion"
  post "celos/guardar_cambiar_estado_a_en_reproduccion"
  post "celos/guardar_cambiar_estado_a_celo_perdido"
  get "celos/buscar_ganado_reproductor"
  get "celos/buscar_esperma_reproductor"

  #REPRODUCCIONES
  get "reproducciones/index" 
  post "reproducciones/lista"
  get "reproducciones/lista"
  get "reproducciones/agregar"
  post "reproducciones/guardar"
  get "reproducciones/editar"
  post "reproducciones/actualizar"
  get "reproducciones/eliminar"
  get "reproducciones/reproducciones_detalles"
  get "reproducciones/cambiar_estado_reproduccion"
  get "reproducciones/cambiar_estado_reproduccion_a_reproduccion_perdido"
  post "reproducciones/guardar_estado_reproduccion_a_reproduccion_perdido"
  get "reproducciones/cambiar_estado_reproduccion_a_reproduccion_finalizada"
  post "reproducciones/guardar_estado_reproduccion_a_reproduccion_finalizada"
  get "reproducciones/buscar_ganado_reproductor"
  get "reproducciones/buscar_esperma_reproductor"
 

  #ESTADOS GANADOS
  get "estados_ganados/index"
  post "estados_ganados/lista"
  get "estados_ganados/lista"
  get "estados_ganados/agregar"
  post "estados_ganados/guardar"
  get "estados_ganados/editar"
  post "estados_ganados/actualizar"
  get "estados_ganados/eliminar"
  get "estados_ganados/buscar_estado_ganado"




#----------------------------FIN BLOQUE DE RUTAS GANATEC----------------------------


#----------------------------INICIO EJEMPLOS DE FONOWARE----------------------------

  #PACIENTES
  post "pacientes/lista"
  get "pacientes/lista"
  get "pacientes/agregar"
  post "pacientes/guardar"
  get "pacientes/eliminar"
  get "pacientes/editar"
  post "pacientes/actualizar"
  get "pacientes/index"
  get "pacientes/buscar_paciente"
  get "pacientes/buscar_persona"
  get "pacientes/buscar_paciente_cita"

  #PACIENTES DETALLES FONO
  get "pacientes_detalles_fono/paciente_detalle_fono"
  post "pacientes_detalles_fono/guardar_detalle_fono"

  #TUTORES
  post "tutores/lista"
  get "tutores/lista"
  get "tutores/agregar"
  post "tutores/guardar"
  get "tutores/eliminar"
  get "tutores/editar"
  post "tutores/actualizar"
  get "tutores/index"
  get "tutores/buscar_tutor"
  get "tutores/buscar_persona"
  get "tutores/tutor_detalle"
  get "tutores/agregar_tutor_detalle"
  post "tutores/guardar_tutor_detalle"
  get "tutores/eliminar_tutor_detalle"

  #PRECIOS
  post "precios/lista"
  get "precios/lista"
  get "precios/agregar"
  post "precios/guardar"
  get "precios/eliminar"
  get "precios/editar"
  post "precios/actualizar"
  get "precios/index"
  get "precios/obtener_datos"
  get "precios/buscar_precio"
  get "precios/marcar_predeterminado"

  #JURISDICCIONES
  get "jurisdicciones/index"
  get "jurisdicciones/buscar_juridisccion_oferta"

  #JURISDICCIONES
  get "informes/index"
  get "informes/indexa"
  get "informes/generar_pdf"

   #INFORMACIONES
  get "informaciones/index"
  get "informaciones/lista"
  post "informaciones/lista"
  get "informaciones/perfiles"
  get "informaciones/enlaces"
  get "informaciones/agregar"
  post "informaciones/guardar"
  get "informaciones/agregar_enlace"
  get "informaciones/guardar_enlace"
  post "informaciones/guardar_enlace"
  get "informaciones/agregar_perfil"
  get "informaciones/guardar_perfil"
  get "informaciones/eliminar"
  get "informaciones/editar"
  post "informaciones/actualizar"
  get "informaciones/editar_enlace"
  post "informaciones/actualizar_enlace"
  get "informaciones/eliminar_enlace"
  get "informaciones/eliminar_rol"

  #DETALLES DEBITOS
  post "detalles_debitos/lista"
  get "detalles_debitos/lista"
  get "detalles_debitos/agregar"
  post "detalles_debitos/guardar"
  get "detalles_debitos/eliminar"
  get "detalles_debitos/editar"
  post "detalles_debitos/actualizar"
  get "detalles_debitos/index"

  #DETALLES CREDITOS
  post "detalles_creditos/lista"
  get "detalles_creditos/lista"
  get "detalles_creditos/agregar"
  post "detalles_creditos/guardar"
  get "detalles_creditos/eliminar"
  get "detalles_creditos/editar"
  post "detalles_creditos/actualizar"
  get "detalles_creditos/index"


  #CLIENTES
  post "clientes/lista"
  get "clientes/lista"
  get "clientes/agregar"
  post "clientes/guardar"
  get "clientes/eliminar"
  get "clientes/editar"
  post "clientes/actualizar"
  get "clientes/index"
  get "clientes/buscar_cliente"

#----------------------------FIN EJEMPLOS DE FONOWARE---------------------------------



#-----------------------INICIO BLOQUE DE RUTAS KERNEL DEL SISTEMA(NO TOCAR)---------------


  #PERSONAS
  post "personas/lista"
  get "personas/lista"
  get "personas/agregar"
  get "personas/agregar_persona_senatics"
  post "personas/guardar"
  post "personas/guardar_persona_senatics"
  get "personas/eliminar"
  get "personas/editar"
  post "personas/actualizar"
  get "personas/index"
  get "personas/mostrar_formulario"
  post "personas/unificar_persona"
  get "personas/obtener_datos"
  get "personas/buscar_persona_senatics"
  get "personas/buscar_chofer"

  #ROLES
  post "roles/lista"
  get "roles/lista"
  get "roles/agregar"
  post "roles/guardar"
  get "roles/eliminar"
  get "roles/editar"
  post "roles/actualizar"
  get "roles/accesos"
  get "roles/agregar_acceso"
  get "roles/guardar_acceso"
  get "roles/eliminar_acceso"
  get "roles/index"

  #CONTROLADORES
  post "controladores/lista"
  get "controladores/lista"
  get "controladores/agregar"
  post "controladores/guardar"
  get "controladores/eliminar"
  get "controladores/editar"
  post "controladores/actualizar"
  get "controladores/acciones"
  get "controladores/agregar_accion"
  post "controladores/guardar_accion"
  get "controladores/eliminar_accion"
  get "controladores/index"

  #Usuarios
  get "usuarios/cambiar_perfil_actual"
  get "usuarios/mi_cuenta"
  post "usuarios/actualizar_mi_cuenta"
  post "usuarios/actualizar_mi_password"
  get "usuarios/perfiles"
  get "usuarios/agregar_perfil"
  get "usuarios/guardar_perfil"
  get "usuarios/eliminar_perfil"
  post "usuarios/actualizar_password"
  get "usuarios/reset_password"
  get "usuarios/perfiles"
  get 'usuarios/index'
  get 'usuarios/lista'
  post 'usuarios/lista'
  get "usuarios/agregar"
  post "usuarios/guardar"
  get "usuarios/eliminar"
  get "usuarios/editar"
  post "usuarios/actualizar"
  get 'usuarios/buscar_persona'
  post 'usuarios/cambiar_estado_usuario'

  #Login
  get 'login' => "usuarios_sessions#new",      :as => :login
  get 'logout' => "usuarios_sessions#destroy", :as => :logout
  post "usuarios_sessions/create"
  get "usuarios_sessions/acceso_denegado"
  get "usuarios_sessions/new"
  get "usuarios_sessions/mantenimiento"

  get "principal/buscar_institucion"
  get "principal/buscar_persona"
  get "principal/buscar_usuario"
  post "principal/guardar_recuperar_password"
  get "principal/recuperar_password"
  post "principal/guardar_usuario"
  get "principal/activar_cuenta"
  get "principal/agregar_usuario"
  get "contactos" => "principal#contactos", :as => :contactos
  get "index" => "principal#index", :as => :index
  get "about" => "principal#about", :as => :about
  get "legal" => "principal#legal", :as => :legal
  get "index" => "principal#index", :as => :indexv

  root 'principal#index'

  get "application/autocompletar" => 'application#autocompletar', :as => :autocompletar

 #------------------------------------------------------------

end
