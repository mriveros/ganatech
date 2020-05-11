class CelosController < ApplicationController

before_filter :require_usuario


  def index
  

  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_celo_id].present?

      cond << "celo_id = ?"
      args << params[:form_buscar_celo_id]

    end

    if params[:form_buscar_celo_ganado_rfid].present?

      cond << "ganado_rfid = ?"
      args << params[:form_buscar_celo_ganado_rfid]

    end

    if params[:form_buscar_celo_ganado_nombre].present?

      cond << "hectareas  ilike ?"
      args << "%#{params[:form_buscar_celo_ganado_nombre]}%"

    end

    if params[:form_buscar_celo_ganado_rp].present?

      cond << "ganado_rp = ?"
      args << params[:form_buscar_celo_ganado_rp]

    end

    if params[:form_buscar_ganado_fecha_inicio].present?

      cond << "fecha_inicio = ?"
      args << params[:form_buscar_ganado_fecha_inicio]

    end

    if params[:form_buscar_celo_fecha_fin].present?

      cond << "fecha_fin = ?"
      args << params[:form_buscar_celo_fecha_fin]

    end

    if params[:form_buscar_celo_descripcion].present?

      cond << "celo_descripcion = ?"
      args << params[:form_buscar_celo_descripcion]

    end

    if params[:form_buscar_celo][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_celo][:hacienda_id]

    end

    if params[:form_buscar_celo][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_celo][:hacienda_id]

    end

    if params[:form_buscar_celo][:estado_celo_id].present?

      cond << "estado_celo_id = ?"
      args << params[:form_buscar_celo][:estado_celo_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @celos =  VCelo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VCelo.where(cond).count

    else
     
      @celos = VCelo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VCelo.count

    end

    @total_registros = VCelo.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @celo = Celo.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false
    

    if @valido
      
      @celo = Celo.new()
      @celo.ganado_id = params[:ganado_id]
      @celo.descripcion = params[:descripcion]
      @celo.observacion = params[:observacion]
      @celo.fecha_inicio = params[:fecha_inicio]
      @celo.fecha_fin = params[:fecha_fin]
      @celo.estado_celo_id = params[:estado_celo][:id]

      if @celo.save

        auditoria_nueva("registrar nuevo celo", "celos", @celo)
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
    
    @celo = Celo.find(params[:celo_id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

     @valido = true
    @msg = ""
    @guardado_ok = false

    @celo = Celo.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("actualizar celo ganado", "celos", @celo)
    

    if @valido
      
      
      @celo.ganado_id = params[:ganado_id]
      @celo.descripcion = params[:descripcion]
      @celo.observacion = params[:observacion]
      @celo.fecha_inicio = params[:fecha_inicio]
      @celo.fecha_fin = params[:fecha_fin]
      @celo.estado_celo_id = params[:estado_celo][:id]

        if @celo.save

          auditoria_despues(@celo, auditoria_id)
          @celo_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    
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

    Celo.transaction do

      @celo = Celo.find(params[:id])

      @celo_elim = @celo

      if valido

        if @celo.destroy

          auditoria_nueva("eliminar celo", "celos", @celo_elim)
          @ganado = Ganado.where("id = ?", @ganado_elim.ganado_id).first
          @ganado.estado_ganado_id = PARAMETRO[:estado_ganado_activo]
          
          if @ganado.save

            @eliminado = true

          end
          
        end

      end

    end #end transaction
    
    rescue Exception => exc  
      
      if exc.present?        
      
        @excep = exc.message.split(':')    
        @msg = "El celo contiene datos relacionados."
        @eliminado = false
      
      end
        
    respond_to do |f|

      f.js

    end

  end


  def celos_detalles
    
    @celo_detalle = VCelo.where("celo_id = ?", params[:celo_id])


     respond_to do |f|

      f.js

    end
  
  end


end