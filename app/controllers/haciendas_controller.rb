class HaciendasController < ApplicationController

before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_haciendas_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_haciendas_id]

    end

     if params[:form_buscar_haciendas_descripcion].present?

      cond << "hacienda ilike ?"
      args << "%#{params[:form_buscar_haciendas_descripcion]}%"

    end    


    if params[:form_buscar_haciendas][:departamento_id].present?

      cond << "departamento_id = ?"
      args << "#{params[:form_buscar_haciendas][:departamento_id]}"

    end


    if params[:form_buscar_haciendas][:jurisdiccion_id].present?

      cond << "jurisdiccion_id = ?"
      args << "#{params[:form_buscar_haciendas][:jurisdiccion_id]}"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @haciendas =  VHacienda.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VHacienda.where(cond).count

    else

      @haciendas = VHacienda.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VHacienda.count

    end

    @total_registros = VHacienda.count

    respond_to do |f|

      f.js

    end

  end
 
  def agregar

    @hacienda = Hacienda.new

    respond_to do |f|

      f.js
      
    end

  end

  def guardar

    valido = true
    @msg = ""
    @hacienda_ok = false

    
    unless params[:hacienda][:descripcion].present?

      valido = false
      @msg += "Es necesario asignar una descripción. "

    end

    unless params[:hacienda][:departamento_id].present?

      valido = false
      @msg += "Debe seleccionar un departamento. "

    end

    unless params[:hacienda][:jurisdiccion_id].present?

      valido = false
      @msg += "Debe seleccionar un distrito. "

    end
    
    if valido
    
      @hacienda = Hacienda.new()
      @hacienda.descripcion = params[:hacienda][:descripcion].upcase
      @hacienda.departamento_id = params[:hacienda][:departamento_id]
      @hacienda.jurisdiccion_id = params[:hacienda][:jurisdiccion_id]
      @hacienda.observacion = params[:observacion] 

      if @hacienda.save

        auditoria_nueva("registrar hacienda", "haciendas", @hacienda)
        @hacienda_ok = true   

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

  def eliminar

    valido = true
    @msg = ""

    @hacienda = Hacienda.find(params[:id])

    @hacienda_elim = @hacienda

    if valido

      if @hacienda.destroy

        auditoria_nueva("eliminar hacienda", "haciendas", @hacienda_elim)
        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar la Hacienda. Compruebe si contiene datos relacionados. "

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

    @hacienda = Hacienda.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""


    unless params[:hacienda][:descripcion].present?

      valido = false
      @msg += "Es necesario asignar una descripción. "

    end

    unless params[:hacienda][:departamento_id].present?

      valido = false
      @msg += "Debe seleccionar un departamento. "

    end

    unless params[:hacienda][:jurisdiccion_id].present?

      valido = false
      @msg += "Debe seleccionar un distrito. "

    end

    @hacienda = Hacienda.find(params[:hacienda][:id])
    auditoria_id = auditoria_antes("actualizar hacienda", "haciendas", @hacienda)

    if valido

      @hacienda.descripcion = params[:hacienda][:descripcion].upcase
      @hacienda.departamento_id = params[:hacienda][:departamento_id]
      @hacienda.jurisdiccion_id = params[:hacienda][:jurisdiccion_id]
      @hacienda.observacion = params[:hacienda][:observacion]

      if @hacienda.save

        auditoria_despues(@hacienda, auditoria_id)
        @hacienda_ok = true

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
  

  def buscar_jurisdiccion

    if params[:hacienda_departamento_id]
      
      @jurisdicciones = Jurisdiccion.where("departamento_id = ? and estado = true", params[:hacienda_departamento_id])
    
    end

    respond_to do |f|
      
      f.json { render :json => @jurisdicciones }
    
    end
  
  end

  def marcar_predeterminado

    @guardado_ok = false    
    @msg = ""

    Hacienda.update_all(predeterminado: false)

    @hacienda = Hacienda.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("Marcar hacienda predeterminada", "hacienda", @hacienda)
    @hacienda.predeterminado = true

    if @hacienda.save

        auditoria_despues(@hacienda, auditoria_id)
        @guardado_ok = true
        @msg = "Hacienda marcada como predeterminado exitosamente."

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