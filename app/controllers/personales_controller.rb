class PersonalesController < ApplicationController

before_filter :require_usuario
skip_before_action :verify_authenticity_token

  def index
   

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_personales_id].present?

      cond << "personales.id = ?"
      args << params[:form_buscar_personales_id]

    end

    if params[:form_buscar_personales_ruc].present?

      cond << "personales.ruc_ci = ?"
      args << params[:form_buscar_personales_ruc]

    end

     if params[:form_buscar_personales_razon_social].present?

      cond << "personales.nombre_razon_social ilike ?"
      args << "%#{params[:form_buscar_personales_razon_social]}%"

    end

    if params[:form_buscar_personales_direccion].present?

      cond << "personales.direccion ilike ?"
      args << "%#{params[:form_buscar_personales_direccion]}%"

    end

    if params[:form_buscar_personales_telefono].present?

      cond << "personales.telefono ilike ?"
      args << "%#{params[:form_buscar_personales_telefono]}%"

    end

    if params[:form_buscar_personales_observacion].present?

      cond << "personales.telefono ilike ?"
      args << "%#{params[:form_buscar_personales_observacion]}%"

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @personales =  VPersonal.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPersonal.where(cond).count
      
    else

      @personales = VPersonal.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPersonal.count

    end

    @total_registros = personal.count

    respond_to do |f|
      
      f.js
      
    end

  end

  def agregar

    @personal = personal.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:personal][:nombre_razon_social].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre o Razón Social. \n"

    end

    unless params[:personal][:ruc_ci].present?

      @valido = false
      @msg += "Debe Completar el campo con el RUC o CI. \n"

    end

    

    if @valido
      
      @personal = Personal.new()
      @personal.nombre_razon_social = params[:personal][:nombre_razon_social].upcase
      @personal.ruc_ci = params[:personal][:ruc_ci]
      @personal.direccion = params[:personal][:direccion].upcase
      @personal.telefono = params[:personal][:telefono]
      @personal.observacion = params[:personal][:observacion]

        if @personal.save

          auditoria_nueva("registrar personal", "personales", @personal)
         
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
    
    @personal = personal.find(params[:id])

    respond_to do |f|
      
        f.js
      
  end

  end

  def actualizar

    valido = true
    @msg = ""

    unless params[:personal][:nombre_razon_social].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre o Razón Social. \n"

    end

    unless params[:personal][:ruc_ci].present?

      @valido = false
      @msg += "Debe Completar el campo con el RUC o CI. \n"

    end

    @personal = personal.find(params[:personal_id])

    auditoria_id = auditoria_antes("actualizar personal", "personales", @personal)

    if valido

      @personal.nombre_razon_social = params[:personal][:nombre_razon_social].upcase
      @personal.ruc_ci = params[:personal][:ruc_ci]
      @personal.direccion = params[:personal][:direccion].upcase
      @personal.telefono = params[:personal][:telefono]
      @personal.observacion = params[:personal][:observacion]

      if @personal.save

        auditoria_despues(@personal, auditoria_id)
        @personal_ok = true

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

  def buscar_personal
    
    @personas = personal.where("personal_nombre ilike ?", "%#{params[:personal_produccion]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

  def eliminar

    valido = true
    @msg = ""

    @personal = personal.find(params[:id])

    @personal_elim = @personal  

    if valido

      if @personal.destroy

        auditoria_nueva("eliminar personal", "personales", @personal_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el personal."

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