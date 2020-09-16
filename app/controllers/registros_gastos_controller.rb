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

	      @registro_gastos =  VRegistroGasto.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = RegistroGasto.where(cond).count

	    else

	      @registro_gastos = VRegistroGasto.orden_01.paginate(per_page: 10, page: params[:page])
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

	    valido = true
	    @msg = ""

	    @registro_gasto = RegistroGasto.new()
	    @registro_gasto.descripcion = params[:detalle_debito][:descripcion].upcase

	    if @registro_gasto.save

	    	auditoria_nueva("registrar detalle debito", "detalles_debitos", @registro_gasto)
	       
	        @detalle_debito_ok = true
	       

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