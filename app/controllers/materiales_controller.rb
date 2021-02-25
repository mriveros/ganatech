class MaterialesController < ApplicationController

	before_filter :require_usuario

	  def index
	  end

	  def lista

	    cond = []
	    args = []

	    if params[:form_buscar_materiales_id].present?

	      cond << "registro_gasto_id = ?"
	      args << params[:form_buscar_materiales_id]

	    end

	    if params[:form_buscar_materiales_fecha].present?

	      cond << "fecha = ?"
	      args << params[:form_buscar_materiales_fecha]

	    end

	    if params[:form_buscar_materiales_monto].present?

	      cond << "monto = ?"
	      args << params[:form_buscar_materiales_monto]

	    end

	    if params[:form_buscar_materiales_gasto].present?

	      cond << "gasto ilike ?"
	      args << "%#{params[:form_buscar_materiales_gasto]}%"

	    end

	    if params[:form_buscar_materiales_observacion].present?

	      cond << "observacion ilike ?"
	      args << "%#{params[:form_buscar_materiales_observacion]}%"

	    end

	    

	    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

	    if cond.size > 0

	      @materiales =  VMaterial.orden_fecha_desc.where(cond).paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VMaterial.where(cond).count

	    else

	      @materiales = VMaterial.orden_fecha_desc.paginate(per_page: 10, page: params[:page])
	      @total_encontrados = VMaterial.count

	    end

	    @total_registros = VMaterial.count

	    respond_to do |f|

	      f.js

	    end

	  end

	  def agregar

	    @material = Material.new

	    respond_to do |f|
	      f.js
	    end

	  end

	  def guardar

	    @valido = true
	    @msg = ""

	    if @valido

		    @material = Material.new()
		    @material.fecha = params[:fecha]
		    @material.gasto_id = params[:gasto][:id]
		    @material.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
		    @material.observacion = params[:observacion]

		    if @material.save

		    	auditoria_nueva("Registrar nuevo gasto", "registros_gastos", @material)
		       
		        @guardado_ok = true
		       

		    end 

		 end
	         
	    respond_to do |f|

	      f.js

	    end

	  end

	  def eliminar

	    @valido = true
	    @msg = ""
	    @eliminado =false

	    @material = Material.find(params[:id])
	    @material_elim = @material

	    if @valido

	      if @material.destroy

	        auditoria_nueva("Eliminar registro de gastos", "registros_gastos", @material_elim)
	        @eliminado = true

	      end

	    end
	        
	    respond_to do |f|

	      f.js

	    end

	  end

	  def editar

	    @material = Material.find(params[:id])

	    respond_to do |f|

	      f.js

	    end

	  end

	  def actualizar

	    valido = true
	    @msg = ""

	    @material = Material.find(params[:id])
	    auditoria_id = auditoria_antes("actualizar material", "materiales", @material)

	    if valido

	    	@material.fecha = params[:material][:fecha]
		  	@material.gasto_id = params[:material][:gasto_id]
		    @material.monto = params[:material][:monto].to_s.gsub(/[$.]/,'').to_i
		    @material.observacion = params[:material][:observacion]

	      if @material.save

	      	auditoria_despues(@material, auditoria_id)
	        @material_ok = true

	      end

	    end
	               
	        
	    respond_to do |f|

	      f.js

	    end

	  end
	    

end