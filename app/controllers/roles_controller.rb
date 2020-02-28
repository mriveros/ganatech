class RolesController < ApplicationController
  
  before_filter :require_usuario
  
  def index

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_roles_id].present?

      cond << "id = ?"
      args << params[:form_buscar_roles_id]

    end

    if params[:form_buscar_roles_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{quita_acentos(params[:form_buscar_roles_descripcion])}%"

    end
    
    if params[:form_buscar_sistema_descripcion].present?

      cond << "descripcion_sistema ilike ?"
      args << "%#{quita_acentos(params[:form_buscar_sistema_descripcion])}%"

    end

    if cond.size > 0

      cond = cond.join(" and ").lines.to_a + args 
      
      @roles = VRoles.ordenado_descripcion.where(cond).paginate(page: params[:page], per_page: 15)
      @total_encontrados = VRoles.where(cond).count

    else

      @roles = VRoles.ordenado_descripcion.paginate(page: params[:page], per_page: 15)
      @total_encontrados = VRoles.count 

    end

    @total_registros = VRoles.count 

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @rol = Rol.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    @valido = true
    @msg = ""

    @rol = Rol.new(params[:rol])

    unless @rol.descripcion.present?

      @valido = false
      @msg += "El campo descripción no puede quedar vacio.<br />"

    end
    
    unless params[:rol][:sistema_id].present?
      
      @valido = false
      @msg += "Debe seleccionar el sistema.<br/>"
      
    end

    if @valido

      rol = Rol.where("descripcion = ?", @rol.descripcion)

      if rol.present?

        @valido = false
        @msg = "El rol ya existe."

      end

    end

    if @valido
      
      @rol.sistema_id = params[:rol][:sistema_id] if params[:rol][:sistema_id].present?
      
      if @rol.save

        @rol_ok = true

      else

        @msg = "ERROR: No se ha podido registrar."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar

    @rol = Rol.find(params[:id])

    if @rol.destroy

      @eliminado = true

    end

  end

  def editar

    @rol = Rol.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    @valido = true
    @msg = ""

    @rol = Rol.find(params[:rol][:id])

    unless params[:rol][:descripcion].present?

      @valido = false
      @msg += "El campo descripción no puede quedar vacio."

    end
    
    unless params[:rol][:sistema_id].present?
      
      @valido = false
      @msg += "Debe seleccionar el sistema.<br/>"
      
    end

    if @valido

      rol = Rol.where("descripcion = ? and id <> ?", params[:rol][:descripcion], @rol.id )

      if rol.present?

        @valido = false
        @msg = "El rol ya existe."

      end

    end

    if @valido
      
      @rol.descripcion = params[:rol][:descripcion]
      @rol.sistema_id = params[:rol][:sistema_id]
      
      if @rol.save

        @rol_ok = true

      else

        @msg = "Error: No se ha podido actualizar el rol."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def accesos

    @accesos = Acceso.joins(:accion).where("rol_id = ?", params[:rol_id]).order("acciones.controlador_id, acciones.descripcion")

    respond_to do |f|

      f.js

    end
  
  end

  def agregar_acceso

    accesos = Acceso.where('rol_id = ?', params[:rol_id])
    v_acciones = accesos.present? ? accesos.map(&:accion_id) : [0]

    cond = ["id not in (?)"]
    args = [v_acciones]

    if params[:form_buscar_acciones] && params[:form_buscar_acciones][:controlador_id].present?

      cond << "controlador_id = ?"
      args << params[:form_buscar_acciones][:controlador_id]

    end

    if params[:form_buscar_acciones_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{quita_acentos(params[:form_buscar_acciones_descripcion])}%"

    end

    cond = cond.join(" and ").lines.to_a + args 
    @acciones = Accion.orden_id.where(cond).paginate(page: params[:page], per_page: 7)

    respond_to do |f|
      f.js
    end

  end

  def guardar_acceso

    @valido = true
    @msg = ""

    @acceso = Acceso.new

    unless params[:rol_id].present?

      @valido = false
      @msg += "El codigo del rol no puede quedar vacio.<br />"

    end

    unless params[:accion_id].present?

      @valido = false
      @msg += "El codigo de la accion no puede quedar vacio.<br />"

    end

    if @valido

      @acceso.rol_id = params[:rol_id]
      @acceso.accion_id = params[:accion_id]

      if @acceso.save

        @acceso_ok = true

      else

        @msg = "ERROR: No se ha podido registrar el acceso."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_acceso

    @acceso = Acceso.find(params[:id])
    @rol_id = @acceso.rol_id

    if @acceso.destroy

      @eliminado = true

    end

  end
  
end
