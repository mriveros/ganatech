class RegistrosGastosController < ApplicationController

	before_filter :require_usuario

	  def index
	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_detalles_debitos_id].present?

	      cond << "id = ?"
	      args << params[:form_buscar_detalles_debitos_id]

	    end

	    if params[:form_buscar_detalles_debitos_descripcion].present?

	      cond << "descripcion ilike ?"
	      args << "%#{params[:form_buscar_detalles_debitos_descripcion]}%"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @registros_gastos =  VRegistroGasto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = RegistroGasto.where(cond).count

	    else

	      @registros_gastos = VRegistroGasto.orden_01.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = RegistroGasto.count

	    end

	    @total_registros = RegistroGasto.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @registro_gasto = RegistroGasto.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    @valido = true
	    @msg = ""

	    if @valido

		    @registro_gasto = RegistroGasto.new()
		    @registro_gasto.fecha = params[:fecha]
		    @registro_gasto.gasto_id = params[:gasto][:id]
		    @registro_gasto.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
		    @registro_gasto.observacion = params[:observacion]

		    if @registro_gasto.save

		    	auditoria_nueva("Registrar nuevo gasto", "registros_gastos", @registro_gasto)
		       
		        @guardado_ok = true
		       

		    end 

		 end
	         
	    respond_to do |f|

	      f.js

	    end

	  end

	  def eliminar

	    valido = true
	    @msg = ""

	    @registro_gasto = RegistroGasto.find(params[:id])

	    if valido

	      if @registro_gasto.destroy

	        auditoria_nueva("eliminar detalle debito", "detalles_debitos", @registro_gasto)

	        @eliminado = true

	      else

	        @msg = "ERROR: No se ha podido eliminar el detalle de debito."

	      end

	    end
	        
	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @registro_gasto = RegistroGasto.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @registro_gasto = RegistroGasto.find(params[:registro_gasto][:id])
	    auditoria_id = auditoria_antes("actualizar detalle debito", "detalles_debitos", @registro_gasto)

	    if valido

	      
	      @registro_gasto.descripcion = params[:registro_gasto][:descripcion].upcase
	      
	        auditoria_despues(@registro_gasto, auditoria_id)

	      if @registro_gasto.save

	        @registro_gasto_ok = true

	      end

	    end
	               
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end