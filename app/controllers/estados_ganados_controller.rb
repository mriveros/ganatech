class EstadosGanadosController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_estados_ganados_id].present?

      cond << "id = ?"
      args << params[:form_buscar_estados_ganados_id]

    end

 
    if params[:form_buscar_estados_ganados_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_estados_ganados_descripcion]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
 
      @estados_ganados =  EstadoGanado.orden_01.where(cond).paginate(per_page: 12, page: params[:page])
      @total_encontrados = EstadoGanado.where(cond).count

    else

      @estados_ganados = EstadoGanado.orden_01.paginate(per_page: 12, page: params[:page])
      @total_encontrados = EstadoGanado.count

    end

    @total_registros = EstadoGanado.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @estado_ganado = EstadoGanado.new

    respond_to do |f|

      f.js

    end

  end

  def guardar

    valido = true
    @msg = ""
    @estado_ganado_ok = false

    @estado_ganado = EstadoGanado.new()

    @estado_ganado.descripcion = params[:estado_ganado][:descripcion].upcase

    if @estado_ganado.save

      auditoria_nueva("registrar estado ganado", "estados_ganados", @estado_ganado)
      @estado_ganado_ok = true

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

    @estado_ganado = EstadoGanado.find(params[:id])

    @estado_ganado_elim = @estado_ganado

    if valido

      if @estado_ganado.destroy

        auditoria_nueva("eliminar estado ganado", "estados_ganados", @estado_ganado_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el estado ganado. Intente más tarde."

      end

    end
    

    respond_to do |f|

      f.js

    end

  end

  def editar

    @estado_ganado = EstadoGanado.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @estado_ganado = EstadoGanado.find(params[:estado_ganado][:id])
    auditoria_id = auditoria_antes("actualizar estado ganado", "estados_ganados", @estado_ganado)

    if valido

      @estado_ganado.descripcion = params[:estado_ganado][:descripcion].upcase

      if @estado_ganado.save

        auditoria_despues(@estado_ganado, auditoria_id)
        @estado_ganado_ok = true

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


  def buscar_estado_ganado

     @estados_ganados = EstadoGanado.where("descripcion ilike ?", "%#{params[:descripcion]}%")

    respond_to do |f|

      f.html
      f.json { render :json => @estados_ganados }

    end

  end


end
