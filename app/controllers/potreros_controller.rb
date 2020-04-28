class PotrerosController < ApplicationController

before_filter :require_usuario


  def index
  

  end
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_potrero_id].present?

      cond << "potrero_id = ?"
      args << params[:form_buscar_potrero_id]

    end

    if params[:form_buscar_potrero_descripcion].present?

      cond << "potrero  ilike ?"
      args << "%#{params[:form_buscar_potrero_descripcion]}%"

    end

    if params[:form_buscar_potrero_hectareas].present?

      cond << "hectareas  = ?"
      args << params[:form_buscar_potrero_hectareas]

    end

    if params[:form_buscar_potrero][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_potrero][:hacienda_id]

    end

    if params[:form_buscar_potrero][:departamento_id].present?

      cond << "departamento_id = ?"
      args << params[:form_buscar_potrero][:departamento_id]

    end

    if params[:form_buscar_potrero][:jurisdiccion_id].present?

      cond << "jurisdiccion_id = ?"
      args << params[:form_buscar_potrero][:jurisdiccion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @potreros =  VPotrero.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPotrero.where(cond).count

    else
     
      @potreros = VPotrero.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPotrero.count

    end

    @total_registros = VPotrero.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @potrero = Potrero.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:potrero][:descripcion].present?

      @valido = false
      @msg += " Debe Completar el campo descripción. \n"

    end

    unless params[:potrero][:hectareas].present?

      @valido = false
      @msg += " Debe agregar una cantidad aproximada de hectareas. \n"

    end

    

    if @valido
      
      @potrero = Potrero.new()
      @potrero.descripcion = params[:potrero][:descripcion].upcase
      @potrero.hectareas = params[:potrero][:hectareas]
      @potrero.hacienda_id = params[:potrero][:hacienda_id]
      @potrero.observacion = params[:observacion]

        if @potrero.save

          auditoria_nueva("registrar potrero nuevo", "potreros", @potrero)
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def editar
    
    @potrero = Potrero.find(params[:potrero_id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

     @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:potrero][:descripcion].present?

      @valido = false
      @msg += " Debe Completar el campo descripción. \n"

    end

    unless params[:potrero][:hectareas].present?

      @valido = false
      @msg += " Debe agregar una cantidad aproximada de hectareas. \n"

    end

    @potrero = Potrero.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("actualizar potrero", "potreros", @potrero)
    

    if @valido
      
      
      @potrero.descripcion = params[:potrero][:descripcion].upcase
      @potrero.hectareas = params[:potrero][:hectareas]
      @potrero.hacienda_id = params[:potrero][:hacienda_id]
      @potrero.observacion = params[:potrero][:observacion]

        if @potrero.save

          auditoria_despues(@potrero, auditoria_id)
          @potrero_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep
      
      end                

    respond_to do |f|

      f.js

    end
  
  end


 def eliminar

    valido = true
    @msg = ""

    @potrero = Potrero.find(params[:id])

    @potrero_elim = @potrero

    if valido

      if @potrero.destroy

        auditoria_nueva("eliminar potrero", "potreros", @potrero_elim)
        @eliminado = true
        
      end

    end
    
    rescue Exception => exc  
      # dispone el mensaje de error 
      #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
      
        @excep = exc.message.split(':')    
        @msg = "Este Potrero contiene datos relacionados."
        @eliminado = false
      
      end
        
    respond_to do |f|

      f.js

    end

  end


  def potrero_detalle
    
    @potrero_detalle = VPotrero.where("potrero_id = ?", params[:potrero_id])


     respond_to do |f|

      f.js

    end
  
  end


end