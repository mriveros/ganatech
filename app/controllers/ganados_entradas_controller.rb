class GanadosEntradasController < ApplicationController

  before_filter :require_usuario

  def index
  

  end


  def lista

    cond = []
    args = []

    if params[:form_buscar_ganado_entrada_id].present?

      cond << "ganado_entrada_id = ?"
      args << params[:form_buscar_ganado_entrada_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @ganados =  VGanadoEntrada.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEntrada.where(cond).count

    else
     
      @ganados = VGanadoEntrada.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VGanadoEntrada.count

    end

    @total_registros = VGanadoEntrada.count

    respond_to do |f|
      
     f.js
      
    end

  end


def agregar_entrada_ganado

    @ganado = GanadoEntrada.new

    ultima_produccion = GanadoEntrada.order("created_at").last

    if ultima_produccion.present?

      @codigo_lote = ultima_produccion.codigo_lote.to_i + 1

    else

      @codigo_lote = 1

    end
    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar_entrada_ganado

    @valido = true
    @msg = ""
    @guardado_ok = false
    contador = 0

    raza = Raza.where("id = ?", params[:raza_ganado][:id]).first

    if @valido
      
      while params[:cantidad_lote].to_i > contador.to_i do
        
        @ganado = GanadoEntrada.new()
        @ganado.nombre = nuevo_rp
        @ganado.rp = nuevo_rp
        @ganado.rp_padre = "No Especificado"
        @ganado.rp_madre = "No Especificado"
        @ganado.codigo_rfid = params[:codigo_rfid]
        @ganado.potrero_id = params[:potrero][:id]
        @ganado.peso_promedio = params[:peso_promedio]
        @ganado.sexo_ganado_id = params[:sexo_ganado][:id]
        @ganado.tipo_ganado_id = raza.tipo_ganado_id
        @ganado.etapa_ganado_id = params[:etapa_ganado][:id]
        @ganado.raza_id = params[:raza_ganado][:id]
        @ganado.tipo_concepcion_id = params[:tipo_concepcion][:id]
        @ganado.estado_ganado_id = params[:estado_ganado][:id]
        @ganado.observacion = params[:observacion]
        @ganado.codigo_lote = params[:codigo_lote]
        @ganado.finalidad_ganado_id = params[:finalidad_ganado][:id]

        if @ganado.save

          auditoria_nueva("registrar ganado", "ganados", @ganado)
          @guardado_ok = true
          contador = contador + 1
         
        end 

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


  def eliminar_entrada_ganado

    @valido = true
    @msg = ""

    @ganado = Ganado.find(params[:id])

    @ganado_elim = @ganado  

    if @valido

      if @ganado.destroy

        auditoria_nueva("eliminar ganado", "ganados", @ganado_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el Ganado."

      end

    end

    rescue Exception => exc  
     
      if exc.present?        
          
        @excep = exc.message.split(':')    
        @msg = @excep
        @eliminado = false
        
      end
        
    respond_to do |f|

      f.js

    end

  end


  def obtener_etapa_ganado

    @etapas_ganados = EtapaGanado.where("sexo_ganado_id = ?", params[:sexo_ganado_id])
    
    respond_to do |f|
      
      f.json { render :json => @etapas_ganados }
    
    end

  end

  



end