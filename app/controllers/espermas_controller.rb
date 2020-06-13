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

    ultimo_codigo = Esperma.order("created_at").last
    @nuevo_numero_pajuela = ultimo_codigo.id + 1

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

      if params[:esperma_procedencia][:id].to_i == PARAMETRO[:esperma_local].to_i
          
        @esperma.ganado_id = params[:ganado_id]
        ganado = Ganado.where("id = ?", params[:ganado_id]).first
        @esperma.raza_id = ganado.raza_id

      else

        @esperma.raza_id = params[:raza][:id]
      
      end

      @esperma.numero_pajuela = params[:numero_pajuela]
      @esperma.descripcion = params[:descripcion].upcase
      @esperma.observacion = params[:observacion]
      @esperma.estado_esperma_id = PARAMETRO[:estado_esperma_activo]
      @esperma.esperma_procedencia_id = params[:esperma_procedencia][:id]
      @esperma.costo_esperma = params[:costo]
      @esperma.cantidad = params[:cantidad]
      @esperma.fecha_registro = params[:fecha_registro]
      @esperma.costo_total = params[:cantidad].to_i * params[:costo].to_i

      if @esperma.save

        auditoria_nueva("agregar nueva muestra esperma", "espermas", @esperma)
        @guardado_ok = true

      end

    end

    rescue Exception => exc  
  
      if exc.present?

        @guardado_ok = false
        @excep = exc.message.split(':')    
        @msg = @excep.to_s
      
      end                

    respond_to do |f|

      f.js

    end
  
  end

  def editar
    
    @esperma = Esperma.find(params[:esperma_id])

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
      
      @esperma.estado_esperma_id = params[:esperma][:estado_esperma_id]
      @esperma.observacion = params[:esperma][:observacion]
      
      if @esperma.save

        auditoria_despues(@esperma, auditoria_id)        
        @guardado_ok = true

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

    @valido = true
    @msg = ""
    @eliminado = false

    Esperma.transaction do

      @esperma = Esperma.find(params[:id])
      @esperma_elim = @esperma
      reproduccion = Reproduccion.where("esperma_id = ?",@esperma.id).first
      
      if reproduccion.present?

        @valido = false
        @msg = "La muestra ya ha sido utilizada en una reproducción"

      end

      if @valido

        if @esperma.destroy

          @eliminado = true
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

  def buscar_ganado

  
    @ganados = VGanado.where("nombre ilike ? and sexo_ganado_id = ? and estado_ganado_id = ? and etapa_ganado_id in (?)", "%#{params[:ganado]}%", params[:sexo_ganado_id], PARAMETRO[:estado_ganado_activo], [PARAMETRO[:etapa_ganado_torito], 
      PARAMETRO[:etapa_ganado_toro]])
    
    respond_to do |f|
      
      f.html
      f.json { render :json => @ganados }
    
    end

  end


end