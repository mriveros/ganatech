class AltasProduccionesController < ApplicationController

before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_alta_produccion_id].present?

      cond << "alta_produccion_id = ?"
      args << params[:form_buscar_alta_produccion_id]

    end

    if params[:form_buscar_alta_produccion_periodo].present?

      cond << "periodo = ?"
      args << params[:form_buscar_alta_produccion_periodo]

    end

    if params[:form_buscar_alta_produccion_ganado_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_alta_produccion_ganado_nombre]}%"

    end 

    if params[:form_buscar_alta_produccion_ganado_rp].present?

      cond << "ganado_rp ilike ?"
      args << "%#{params[:form_buscar_alta_produccion_ganado_rp]}%"

    end    


    if params[:form_buscar_alta_produccion_ganado_rfid].present?

      cond << "ganado_rfid = ?"
      args << params[:form_buscar_alta_produccion_ganado_rfid]

    end


    if params[:form_buscar_alta_produccion][:estado_alta_produccion_id].present?

      cond << "estado_alta_produccion_id = ?"
      args << params[:form_buscar_alta_produccion][:estado_alta_produccion_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @altas_producciones =  VAltaProduccion.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VAltaProduccion.where(cond).count

    else

      @altas_producciones = VAltaProduccion.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VAltaProduccion.count

    end

    @total_registros = VAltaProduccion.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @alta_produccion = AltaProduccion.new

    respond_to do |f|

      f.js
      
    end

  end

  def guardar

    valido = true
    @msg = ""
    @precio_ok = false

    @precio = Precio.new()
    @precio.codigo = params[:precio][:codigo].upcase
    @precio.descripcion = params[:precio][:descripcion].upcase
    @precio.monto = params[:precio][:monto].to_s.gsub(/[$.]/,'').to_i
    

      if @precio.save

        auditoria_nueva("registrar precio", "precios", @precio)
       
        @precio_ok = true
       

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

    @precio = Precio.find(params[:id])

    @precio_elim = @precio

    if valido

      if @precio.destroy

        auditoria_nueva("eliminar precio", "precios", @precio)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el precio."

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

    @precio = Precio.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @precio = Precio.find(params[:precio][:id])
    auditoria_id = auditoria_antes("actualizar precio", "precios", @precio)

    if valido

      @precio.codigo = params[:precio][:codigo].upcase
      @precio.descripcion = params[:precio][:descripcion].upcase
      @precio.monto =  params[:precio][:monto].to_s.gsub(/[$.]/,'').to_i
     

      if @precio.save

        auditoria_despues(@precio, auditoria_id)
        @precio_ok = true

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
  

  def buscar_precio

     @precios = Precio.where("descripcion ilike ?", "%#{params[:descripcion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @precios }
    
    end

  end

  def marcar_predeterminado

    @guardado_ok = false    
    @msg = ""

    Precio.update_all(predeterminado: false)

    @precio = Precio.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("Marcar precio predeterminado", "precios", @precio)
    @precio.predeterminado = true

    if @precio.save

        auditoria_despues(@precio, auditoria_id)
        @guardado_ok = true
        @msg = "Precio marcado como predeterminado exitosamente."

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