class EspermasController < ApplicationController

  before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_esperma_id].present?

      cond << "esperma_id = ?"
      args << params[:form_buscar_esperma_id]

    end

    if params[:form_buscar_esperma_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_esperma_descripcion]}%"

    end

    if params[:form_buscar_esperma_numero_pajuela].present?

      cond << "numero_pajuela  = ?"
      args << params[:form_buscar_esperma_numero_pajuela]

    end

    if params[:form_buscar_esperma][:raza_id].present?

      cond << "raza_id = ?"
      args << params[:form_buscar_esperma][:raza_id]

    end


    if params[:form_buscar_esperma][:esperma_procedencia_id].present?

      cond << "esperma_procedencia_id = ?"
      args << params[:form_buscar_esperma][:esperma_procedencia_id]

    end

    if params[:form_buscar_esperma_cantidad].present?

      cond << "cantidad = ?"
      args << params[:form_buscar_esperma_cantidad]

    end

    if params[:form_buscar_esperma_costo].present?

      cond << "costo_esperma = ?"
      args << params[:form_buscar_esperma_costo]

    end

    if params[:form_buscar_esperma_costo_total].present?

      cond << "costo_total = ?"
      args << params[:form_buscar_esperma_costo_total]

    end

    if params[:form_buscar_esperma][:estado_esperma_id].present?

      cond << "estado_esperma_id = ?"
      args << params[:form_buscar_esperma][:estado_esperma_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @espermas =  VEsperma.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VEsperma.where(cond).count

    else
     
      @espermas = VEsperma.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VEsperma.count

    end

    @total_registros = VEsperma.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @esperma = Esperma.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

   

    if @valido
        
      @esperma = Esperma.new()
     

      if @esperma.save

        auditoria_nueva("agregar nueva muestra esperma", "espermas", @esperma)
        @guardado_ok = true

      end

    end

    rescue Exception => exc  
  
      if exc.present?

        @excep = exc.message.split(':')    
        @msg = @excep.to_s
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def editar
    
    @celo = Esperma.find(params[:esperma_id])

    respond_to do |f|
      
        f.js
      
    end

  end

  def actualizar

    @valido = true
    @msg = ""
    @guardado_ok = false

    @esperma = Esperma.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("actualizar esperma", "espermas", @esperma)

    if @valido
     

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

    @valido = true
    @msg = ""

    Esperma.transaction do

      @esperma = Esperma.find(params[:id])
      @esperma_elim = @esperma
      reproduccion = Reproduccion.where("esperma_id = ?",@esperma.id)
      
      if reproduccion.present?

        @valido = false
        @msg = "La muestra ya ha sido utilizada en una reproducción"

      end

      

      if valido

        if @esperma.destroy

          auditoria_nueva("eliminar esperma", "espermas", @esperma_elim)
          
        end

      end

    end #end transaction
    
    rescue Exception => exc  
      
      if exc.present?        
      
        @excep = exc.message.split(':')    
        @eliminado = false
      
      end
        
    respond_to do |f|

      f.js

    end

  end


  def esperma_detalle
    
    @esperma_detalle = VEsperma.where("esperma_id = ?", params[:esperma_id]).first


     respond_to do |f|

      f.js

    end
  
  end


end