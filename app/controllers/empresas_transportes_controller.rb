class EmpresasTransportesController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_empresas_transportes_id].present?

      cond << "id = ?"
      args << params[:form_buscar_empresas_transportes_id]

    end


    if params[:form_buscar_empresas_transportes_nombre].present?

      cond << "nombre ilike ?"
      args << "%#{params[:form_buscar_empresas_transportes_nombre]}%"

    end

    if params[:form_buscar_empresas_transportes_ruc_ci].present?

      cond << "ruc_ci ilike ?"
      args << "%#{params[:form_buscar_empresas_transportes_ruc_ci]}%"

    end

    if params[:form_buscar_empresas_transportes_telefono].present?

      cond << "telefono ilike ?"
      args << "%#{params[:form_buscar_empresas_transportes_telefono]}%"

    end

    if params[:form_buscar_empresas_transportes_direccion].present?

      cond << "direccion ilike ?"
      args << "%#{params[:form_buscar_empresas_transportes_direccion]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @empresas_transportes =  EmpresaTransporte.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = EmpresaTransporte.where(cond).count

    else

      @empresas_transportes = EmpresaTransporte.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = EmpresaTransporte.count

    end

    @total_registros = EmpresaTransporte.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @empresa_transporte = EmpresaTransporte.new

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
    rescue Exception => exc
      # dispone el mensaje de error
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?
        @excep = exc.message.split(':')
        @msg = @excep[3].concat(" "+@excep[4])
        @eliminado = false
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
