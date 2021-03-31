class TrabajosController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_trabajos_id].present?

      cond << "id = ?"
      args << params[:form_buscar_trabajos_id]

    end

 
    if params[:form_buscar_trabajos_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_trabajos_descripcion]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
 
      @trabajos =  Trabajo.orden_01.where(cond).paginate(per_page: 12, page: params[:page])
      @total_encontrados = Trabajo.where(cond).count

    else

      @trabajos = Trabajo.orden_01.paginate(per_page: 12, page: params[:page])
      @total_encontrados = Trabajo.count

    end

    @total_registros = Trabajo.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @trabajo = Trabajo.new

    respond_to do |f|

      f.js

    end

  end

  def guardar

    valido = true
    @msg = ""
    @trabajo_ok = false

    @trabajo = Trabajo.new()

    @trabajo.descripcion = params[:trabajo][:descripcion].upcase

    if @trabajo.save

      auditoria_nueva("registrar trabajo", "trabajos", @trabajo)
      @trabajo_ok = true

    end

    rescue Exception => exc
      # dispone el mensaje de error
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?
        @excep = exc.message.split(':')
        @msg = @excep[3].concat(" "+@excep[4].to_s)

      end

    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @trabajo = Trabajo.find(params[:id])

    @trabajo_elim = @trabajo

    if valido

      if @trabajo.destroy

        auditoria_nueva("eliminar trabajo", "trabajos", @trabajo_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el trabajo. Intente más tarde."

      end

    end
    

    respond_to do |f|

      f.js

    end

  end

  def editar

    @trabajo = Trabajo.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @trabajo = Trabajo.find(params[:trabajo][:id])
    auditoria_id = auditoria_antes("actualizar trabajo", "trabajos", @trabajo)

    if valido

      @trabajo.descripcion = params[:trabajo][:descripcion].upcase

      if @trabajo.save

        auditoria_despues(@trabajo, auditoria_id)
        @trabajo_ok = true

      end

    end
    rescue Exception => exc
      # dispone el mensaje de error
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?

        @excep = exc.message.split(':')
        @msg = @excep[3].concat(" "+@excep[4])

      end

    respond_to do |f|

      f.js

    end

  end




end