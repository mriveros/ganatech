class FlotasController < ApplicationController

before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_flotas_id].present?

      cond << "flotas.id = ?"
      args << params[:form_buscar_flotas_id]

    end

     if params[:form_buscar_flotas_codigo].present?

      cond << "flotas.codigo = ?"
      args << params[:form_buscar_flotas_codigo]

    end

    if params[:form_buscar_flotas_marca_id].present?

      cond << "flotas.marca_id = ?"
      args << params[:form_buscar_flotas_marca_id]

    end

    if params[:form_buscar_flotas_modelo].present?

      cond << "flotas.modelo = ?"
      args << params[:form_buscar_flotas_modelo]

    end

    if params[:form_buscar_flotas_chapa].present?

      cond << "flotas.chapa = ?"
      args << params[:form_buscar_flotas_chapa]

    end

    if params[:form_buscar_flotas_descripcion].present?

      cond << "flotas.descripcion ilike ?"
      args << "%#{params[:form_buscar_flotas_descripcion]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @flotas =  Flota.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = Flota.where(cond).count

    else

      @flotas = Flota.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Flota.count

    end

    @total_registros = Flota.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @flota = Flota.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""
    @flota_ok = false

    @flota = Flota.new()
    @flota.codigo_flota = params[:flota][:codigo_flota].upcase
    @flota.marca_id = params[:flota][:marca_id]
    @flota.modelo = params[:flota][:modelo].upcase
    @flota.chapa = params[:flota][:chapa].upcase
    @flota.descripcion = params[:flota][:descripcion].upcase

      if @flota.save

        auditoria_nueva("registrar flota", "flotas", @flota)
       
        @flota_ok = true
       

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

    @flota = Flota.find(params[:id])

    if valido

      if @flota.destroy

        auditoria_nueva("eliminar flota", "flotas", @flota)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar la flota."

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

    @flota = Flota.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @flota = Flota.find(params[:flota][:id])
    auditoria_id = auditoria_antes("actualizar flota", "flotas", @flota)

    if valido

      @flota.codigo_flota = params[:flota][:codigo_flota].upcase
      @flota.descripcion = params[:flota][:descripcion].upcase
      @flota.marca_id =  params[:flota][:marca_id]
      @flota.modelo = params[:flota][:modelo].upcase
      @flota.chapa = params[:flota][:chapa].upcase

      if @flota.save

        auditoria_despues(@flota, auditoria_id)
        @flota_ok = true

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
    
  def obtener_datos
    @persona= Persona.find_by_id(params[:persona_id])
    
    respond_to do |f|  
      f.html
      f.json { render :json => @persona }
    end
  end

  def agregar_persona_senatics

    respond_to do |f|
      f.js
    end

  end

  def buscar_flota

     @flotas = VFlota.where("marca ilike ?", "%#{params[:flota_produccion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @flotas }
    
    end

  end



end