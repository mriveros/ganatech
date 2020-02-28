class DetallesCreditosController < ApplicationController

	before_filter :require_usuario

	  def index
	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_detalles_creditos_id].present?

	      cond << "detalles_creditos.id = ?"
	      args << params[:form_buscar_detalles_creditos_id]

	    end

	    if params[:form_buscar_detalles_creditos_descripcion].present?

	      cond << "detalles_creditos.descripcion ilike ?"
	      args << "%#{params[:form_buscar_detalles_creditos_descripcion]}%"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @detalles_creditos =  DetalleCredito.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = DetalleCredito.where(cond).count

	    else

	      @detalles_creditos = DetalleCredito.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = DetalleCredito.count

	    end

	    @total_registros = DetalleCredito.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @detalle_credito = DetalleCredito.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    valido = true
	    @msg = ""

	    @detalle_credito = DetalleCredito.new()
	    @detalle_credito.descripcion = params[:detalle_credito][:descripcion].upcase
	    
	      if @detalle_credito.save

	        auditoria_nueva("registrar detalle credito", "detalles_creditos", @detalle_credito)
	       
	        @detalle_credito_ok = true
	       

	      end 
	  
	        rescue Exception => exc  
	        # dispone el mensaje de error 
	        #puts "Aqui si muestra el error ".concat(exc.message)
	        if exc.present?        
	        @excep = exc.message.split(':')    
	        @msg = @excep[3].concat(" "+@excep[3].to_s)
	        end                
	               
	    respond_to do |f|

	      f.js

	    end

	  end

	  def eliminar

	    valido = true
	    @msg = ""

	    @detalle_credito = DetalleCredito.find(params[:id])

	    if valido

	      if @detalle_credito.destroy

	        auditoria_nueva("eliminar detalle credito", "detalles_creditos", @detalle_credito)

	        @eliminado = true

	      else

	        @msg = "ERROR: No se ha podido eliminar el detalle de credito."

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

	    @detalle_credito = DetalleCredito.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @detalle_credito = DetalleCredito.find(params[:detalle_credito][:id])
	    auditoria_id = auditoria_antes("actualizar detalle credito", "detalles_creditos", @detalle_credito)

	    if valido

	      
	      @detalle_credito.descripcion = params[:detalle_credito][:descripcion].upcase
	      
	        auditoria_despues(@detalle_credito, auditoria_id)

	      if @detalle_credito.save

	        @detalle_credito_ok = true

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