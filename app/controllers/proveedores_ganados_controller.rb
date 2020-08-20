class ProveedoresGanadosController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_proveedores_ganados_id].present?

      cond << "id = ?"
      args << params[:form_buscar_proveedores_ganados_id]

    end


    if params[:form_buscar_proveedores_ganados_nombre_razon_social].present?

      cond << "nombre_razon_social ilike ?"
      args << "%#{params[:form_buscar_proveedores_ganados_nombre_razon_social]}%"

    end

    if params[:form_buscar_proveedores_ganados_ruc_ci].present?

      cond << "ruc_ci ilike ?"
      args << "%#{params[:form_buscar_proveedores_ganados_ruc_ci]}%"

    end

    if params[:form_buscar_proveedores_ganados_direccion].present?

      cond << "direccion ilike ?"
      args << "%#{params[:form_buscar_proveedores_ganados_direccion]}%"

    end

    if params[:form_buscar_proveedores_ganados_telefono].present?

      cond << "telefono ilike ?"
      args << "%#{params[:form_buscar_proveedores_ganados_telefono]}%"

    end

    if params[:form_buscar_proveedores_ganados_email].present?

      cond << "email ilike ?"
      args << "%#{params[:form_buscar_proveedores_ganados_email]}%"

    end

    if params[:form_buscar_proveedores_ganados_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_proveedores_ganados_observacion]}%"

    end



    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @proveedores_ganados =  ProveedorGanado.orden_id.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = ProveedorGanado.where(cond).count

    else

      @proveedores_ganados = ProveedorGanado.orden_id.paginate(per_page: 10, page: params[:page])
      @total_encontrados = ProveedorGanado.count

    end

    @total_registros = ProveedorGanado.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @proveedor_ganado = ProveedorGanado.new

    respond_to do |f|

      f.js

    end

  end

  def guardar

    valido = true
    @msg = ""
    @proveedor_ganado_ok = false

    @proveedor_ganado = ProveedorGanado.new()

    @proveedor_ganado.nombre_razon_social = params[:proveedor_ganado][:nombre_razon_social].upcase
    @proveedor_ganado.ruc_ci = params[:proveedor_ganado][:ruc_ci].upcase
    @proveedor_ganado.direccion = params[:proveedor_ganado][:direccion].upcase
    @proveedor_ganado.telefono = params[:proveedor_ganado][:telefono].upcase
    @proveedor_ganado.email = params[:proveedor_ganado][:email].upcase
    @proveedor_ganado.observacion = params[:proveedor_ganado][:observacion].upcase


    if @proveedor_ganado.save

      auditoria_nueva("registrar proveedor de ganado", "proveedores_ganados", @proveedor_ganado)
      @proveedor_ganado_ok = true

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

    @proveedor_ganado = ProveedorGanado.find(params[:id])

    @proveedor_ganado_elim = @proveedor_ganado

    if valido

      if @proveedor_ganado.destroy

        auditoria_nueva("eliminar proveedor de ganado", "proveedores_ganados", @proveedor_ganado_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el proveedor de ganado. Intente más tarde."

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

    @proveedor_ganado = ProveedorGanado.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @proveedor_ganado = ProveedorGanado.find(params[:proveedor_ganado][:id])
    auditoria_id = auditoria_antes("actualizar proveedor de ganado", "proveedores_ganados", @proveedor_ganado)

    if valido

      @proveedor_ganado.nombre_razon_social = params[:proveedor_ganado][:nombre_razon_social].upcase
      @proveedor_ganado.ruc_ci = params[:proveedor_ganado][:ruc_ci].upcase
      @proveedor_ganado.direccion = params[:proveedor_ganado][:direccion].upcase
      @proveedor_ganado.telefono = params[:proveedor_ganado][:telefono].upcase
      @proveedor_ganado.email = params[:proveedor_ganado][:email].upcase
      @proveedor_ganado.observacion = params[:proveedor_ganado][:observacion].upcase

      if @proveedor_ganado.save

        auditoria_despues(@proveedor_ganado, auditoria_id)
        @proveedor_ganado_ok = true

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


  def buscar_proveedor_ganado

     @proveedores_ganados = ProveedorGanado.where("nombre_razon_social ilike ?", "%#{params[:nombre_razon_social]}%")

    respond_to do |f|

      f.html
      f.json { render :json => @proveedores_ganados }

    end

  end


end
