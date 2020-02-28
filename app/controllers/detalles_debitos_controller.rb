class DetallesDebitosController < ApplicationController

	before_filter :require_usuario

	  def index
	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_detalles_debitos_id].present?

	      cond << "detalles_debitos.id = ?"
	      args << params[:form_buscar_detalles_debitos_id]

	    end

	    if params[:form_buscar_detalles_debitos_descripcion].present?

	      cond << "detalles_debitos.descripcion ilike ?"
	      args << "%#{params[:form_buscar_detalles_debitos_descripcion]}%"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @detalles_debitos =  DetalleDebito.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = DetalleDebito.where(cond).count

	    else

	      @detalles_debitos = DetalleDebito.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = DetalleDebito.count

	    end

	    @total_registros = DetalleDebito.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @detalle_debito = DetalleDebito.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    valido = true
	    @msg = ""

	    @detalle_debito = DetalleDebito.new()
	    @detalle_debito.descripcion = params[:detalle_debito][:descripcion].upcase

	      if @detalle_debito.save

	        auditoria_nueva("registrar detalle debito", "detalles_debitos", @detalle_debito)
	       
	        @detalle_debito_ok = true
	       

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

	    @detalle_debito = DetalleDebito.find(params[:id])

	    if valido

	      if @detalle_debito.destroy

	        auditoria_nueva("eliminar detalle debito", "detalles_debitos", @detalle_debito)

	        @eliminado = true

	      else

	        @msg = "ERROR: No se ha podido eliminar el detalle de debito."

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

	    @detalle_debito = DetalleDebito.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @detalle_debito = DetalleDebito.find(params[:detalle_debito][:id])
	    auditoria_id = auditoria_antes("actualizar detalle debito", "detalles_debitos", @detalle_debito)

	    if valido

	      
	      @detalle_debito.descripcion = params[:detalle_debito][:descripcion].upcase
	      
	        auditoria_despues(@detalle_debito, auditoria_id)

	      if @detalle_debito.save

	        @detalle_debito_ok = true

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