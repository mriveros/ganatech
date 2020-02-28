class ClientesController < ApplicationController

before_filter :require_usuario
skip_before_action :verify_authenticity_token

  def index
  

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_clientes_id].present?

      cond << "clientes.id = ?"
      args << params[:form_buscar_clientes_id]

    end

    if params[:form_buscar_clientes_ruc].present?

      cond << "clientes.ruc = ?"
      args << params[:form_buscar_clientes_ruc]

    end

     if params[:form_buscar_clientes_razon_social].present?

      cond << "clientes.razon_social = ?"
      args << params[:form_buscar_clientes_razon_social]

    end

    if params[:form_buscar_clientes_nombre].present?

      cond << "clientes.cliente_nombre ilike ?"
      args << "%#{params[:form_buscar_clientes_nombre]}%"

    end

    if params[:form_buscar_clientes_apellido].present?

      cond << "clientes.cliente_apellido ilike ?"
      args << "%#{params[:form_buscar_clientes_apellido]}%"

    end

    if params[:form_buscar_clientes_direccion].present?

      cond << "clientes.direccion = ?"
      args << params[:form_buscar_clientes_direccion]

    end

    if params[:form_buscar_clientes_telefono].present?

      cond << "clientes.telefono ilike ?"
      args << "%#{params[:form_buscar_clientes_telefono]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @clientes =  Cliente.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = Cliente.where(cond).count

    else

      @clientes = Cliente.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Cliente.count

    end

    @total_registros = Cliente.count

  	respond_to do |f|
	    
	   f.js
	    
	  end

  end

  def agregar

    @cliente = Cliente.new

    respond_to do |f|
	    
	      f.js
	    
	  end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:cliente][:cliente_nombre].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre. \n"

    end

    unless params[:cliente][:cliente_apellido].present?

      @valido = false
      @msg += "Debe Completar el campo Apellido. \n"

    end

    unless params[:cliente][:direccion].present?

      @valido = false
      @msg += "Debe Completar el campo Dirección. \n"

    end

    unless params[:cliente][:telefono].present?

      @valido = false
      @msg += "Debe Completar el campo Teléfono. \n"

    end

    if @valido
      
      @cliente = Cliente.new()
      @cliente.razon_social = params[:cliente][:razon_social].upcase
      @cliente.ruc = params[:cliente][:ruc]
      @cliente.cliente_nombre = params[:cliente][:cliente_nombre].upcase
      @cliente.cliente_apellido = params[:cliente][:cliente_apellido].upcase
      @cliente.direccion = params[:cliente][:direccion].upcase
      @cliente.telefono = params[:cliente][:telefono]

        if @cliente.save

          auditoria_nueva("registrar cliente", "clientes", @cliente)
         
          @guardado_ok = true
         
        end 

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

  def editar
    
    @cliente = Cliente.find(params[:id])

  	respond_to do |f|
	    
	      f.js
	    
	end

  end

  def actualizar

    valido = true
    @msg = ""
    @cliente = Cliente.find(params[:cliente_id])

    auditoria_id = auditoria_antes("actualizar cliente", "clientes", @cliente)

    if valido

      @cliente.razon_social = params[:cliente][:razon_social].upcase
      @cliente.ruc = params[:cliente][:ruc]
      @cliente.cliente_nombre = params[:cliente][:cliente_nombre].upcase
      @cliente.cliente_apellido =  params[:cliente][:cliente_apellido].upcase
      @cliente.direccion = params[:cliente][:direccion].upcase
      @cliente.telefono = params[:cliente][:telefono]

      if @cliente.save

        auditoria_despues(@cliente, auditoria_id)
        @cliente_ok = true

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

  def buscar_cliente
    
    @personas = Cliente.where("cliente_nombre ilike ?", "%#{params[:cliente_produccion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

  def eliminar

    valido = true
    @msg = ""

    @cliente = Cliente.find(params[:id])

    @cliente_elim = @cliente  

    if valido

      if @cliente.destroy

        auditoria_nueva("eliminar cliente", "clientes", @cliente_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el Cliente."

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

end