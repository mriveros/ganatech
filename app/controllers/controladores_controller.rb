class ControladoresController < ApplicationController
  
  before_filter :require_usuario
  
  def index

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_controladores_id].present?

      cond << "id = ?"
      args << params[:form_buscar_controladores_id]

    end

    if params[:form_buscar_controladores_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{quita_acentos(params[:form_buscar_controladores_descripcion])}%"

    end

    if cond.size > 0

      cond = cond.join(" and ").lines.to_a + args 
      @controladores = Controlador.ordenado_descripcion.where(cond).paginate(page: params[:page], per_page: 15)
      @total_encontrados = Controlador.where(cond).count

    else

      @controladores = Controlador.ordenado_descripcion.paginate(page: params[:page], per_page: 15)
      @total_encontrados = Controlador.count 

    end

    @total_registros = Controlador.count 

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @controlador = Controlador.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    @valido = true
    @msg = ""

    @controlador = Controlador.new(params[:controlador])

    unless @controlador.descripcion.present?

      @valido = false
      @msg += "El campo descripcion no puede quedar vacio.<br />"

    end

    if @valido

      controlador = Controlador.where("descripcion = ?", @controlador.descripcion)

      if controlador.present?

        @valido = false
        @msg = "El controlador ya existe."

      end

    end

    if @valido

      if @controlador.save

        @controlador_ok = true

      else

        @msg = "ERROR: No se ha podido registrar."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar

    @controlador = Controlador.find(params[:id])

    if @controlador.destroy

      @eliminado = true

    end

  end

  def editar

    @controlador = Controlador.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    @valido = true
    @msg = ""

    @controlador = Controlador.find(params[:controlador][:id])

    unless params[:controlador][:descripcion].present?

      @valido = false
      @msg += "El campo descripcion no puede quedar vacio."

    end

    if @valido

      controlador = Controlador.where("descripcion = ? and id <> ?", params[:controlador][:descripcion], @controlador.id )

      if controlador.present?

        @valido = false
        @msg = "El controlador ya existe."

      end

    end

    if @valido

      if @controlador.update_attributes(params[:controlador])

        @controlador_ok = true

      else

        @msg = "Error: No se ha podido actualizar el controlador."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def acciones

    @acciones = Accion.orden_id.where("controlador_id = ?", params[:controlador_id])

    respond_to do |f|

      f.js

    end
  
  end

  def agregar_accion

    @accion = Accion.new

    respond_to do |f|
      f.js
    end

  end

  def guardar_accion

    @valido = true
    @msg = ""

    @accion = Accion.new(params[:accion])

    unless @accion.controlador_id.present?

      @valido = false
      @msg += "El codigo del controlador no puede quedar vacio.<br />"

    end

    unless @accion.descripcion.present?

      @valido = false
      @msg += "El campo descripcion no puede quedar vacio.<br />"

    end

    if @valido

      accion_existente = Accion.where("controlador_id = ? and descripcion = ?", @accion.controlador_id, @accion.descripcion)

      if accion_existente.present?

        @valido = false
        @msg += "Esta acción ya existe."

      end

    end

    if @valido

      if @accion.save

        @accion_ok = true

      else

        @msg = "No se ha podido guardar la acción."

      end

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_accion

    @accion = Accion.find(params[:id])
    @controlador_id = @accion.controlador_id

    if @accion.destroy

      @eliminado = true

    end

  end
  
end
