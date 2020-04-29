class RazasController < ApplicationController

before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_raza_id].present?

      cond << "id = ?"
      args << params[:form_buscar_raza_id]

    end


    if params[:form_buscar_razas_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_razas_descripcion]}%"

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @razas =  Raza.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = Raza.where(cond).count

    else

      @razas = Raza.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Raza.count

    end

    @total_registros = Raza.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @raza = Raza.new

    respond_to do |f|

      f.js
      
    end

  end

  def guardar

    valido = true
    @msg = ""
    @raza_ok = false

    @raza = Raza.new()

    @raza.descripcion = params[:raza][:descripcion].upcase
    
    if @raza.save

      auditoria_nueva("registrar raza", "razas", @raza) 
      @raza_ok = true
       
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

    @raza = Raza.find(params[:id])

    @raza_elim = @raza

    if valido

      if @raza.destroy

        auditoria_nueva("eliminar raza", "razas", @raza_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar la raza. Intente más tarde."

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

    @raza = Raza.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @raza = Raza.find(params[:raza][:id])
    auditoria_id = auditoria_antes("actualizar raza", "razas", @raza)

    if valido

      @raza.descripcion = params[:raza][:descripcion].upcase

      if @raza.save

        auditoria_despues(@raza, auditoria_id)
        @raza_ok = true

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
  

  def buscar_raza

     @razas = Raza.where("descripcion ilike ?", "%#{params[:descripcion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @razas }
    
    end

  end

  
end