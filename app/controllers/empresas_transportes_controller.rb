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
    @empresa_transporte_ok = false

    @empresa_transporte = EstadoGanado.new()

    @empresa_transporte.descripcion = params[:empresa_transporte][:descripcion].upcase

    if @empresa_transporte.save

      auditoria_nueva("registrar empresa de transporte", "empresas_transportes", @empresa_transporte)
      @empresa_transporte_ok = true

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

    @empresa_transporte = EmpresaTransporte.find(params[:id])

    @empresa_transporte_elim = @empresa_transporte

    if valido

      if @empresa_transporte.destroy

        auditoria_nueva("eliminar empresa de transporte", "empresas_transportes", @empresa_transporte_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar la empresa de transporte. Intente más tarde."

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

    @empresa_transporte = EmpresaTransporte.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @empresa_transporte = EmpresaTransporte.find(params[:empresa_transporte][:id])
    auditoria_id = auditoria_antes("actualizar empresa de transporte", "empresas_transportes", @empresa_transporte)

    if valido

      @empresa_transporte.nombre = params[:empresa_transporte][:nombre].upcase

      if @empresa_transporte.save

        auditoria_despues(@empresa_transporte, auditoria_id)
        @empresa_transporte_ok = true

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


  def buscar_empresa_transporte

     @empresas_transportes = EmpresaTransporte.where("nombre ilike ?", "%#{params[:nombre]}%")

    respond_to do |f|

      f.html
      f.json { render :json => @empresas_transportes }

    end

  end


end
