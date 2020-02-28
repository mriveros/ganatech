Rails.application.routes.draw do

  
  namespace 'api' do
    namespace 'v1' do
  
      resources :personas
      resources :usuarios
  
    end
  end  
    
    #CRONTAB
  get "crontab_ultron/index"

    #JURISDICCIONES
  get "jurisdicciones/index"
  get "jurisdicciones/buscar_juridisccion_oferta" 

  #JURISDICCIONES
  get "informes/index"
   get "informes/indexa"
  get "informes/generar_pdf"
  
  

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

    #PRODUCCION
  get "produccion/index"
  get "produccion/lista"
  post "produccion/lista"
  get "produccion/agregar"
  post "produccion/guardar"
  get "produccion/eliminar"
  get "produccion/editar"
  post "produccion/actualizar"
  get "produccion/produccion_detalle_credito"
  get "produccion/produccion_detalle_debito"
  get "produccion/agregar_detalle_credito"
  get "produccion/agregar_detalle_debito"
  post "produccion/guardar_detalle_credito"
  post "produccion/guardar_detalle_debito"
  get "produccion/eliminar_produccion_detalle_credito"
  get "produccion/eliminar_produccion_detalle_debito"
  get "produccion/cambiar_estado_solicitado_a_en_progreso"
  get "produccion/cambiar_estado_en_progreso_a_finalizado"
  get "produccion/cambiar_estado_cobro"
  get "produccion/cambiar_estado_cobro_desconfirmar"
  get "produccion/planilla_resumen_produccion"
  get "produccion/planilla_resumen_produccion_pdf"
  get "produccion/planilla_resumen_produccion_cliente"
  get "produccion/planilla_resumen_produccion_cliente_pdf"

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

    #FLOTAS
  post "flotas/lista"
  get "flotas/lista"
  get "flotas/agregar"
  post "flotas/guardar"
  get "flotas/eliminar"
  get "flotas/editar"
  post "flotas/actualizar"
  get "flotas/index"
  get "flotas/obtener_datos"
  get "flotas/buscar_flota"
  

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

end
