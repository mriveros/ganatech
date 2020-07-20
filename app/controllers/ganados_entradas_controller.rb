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

    if params[:form_buscar_ganado_entrada_procedencia].present?

      cond << "procedencia ilike ?"
      args << "%#{params[:form_buscar_ganado_entrada_procedencia]}%"

    end

    if params[:form_buscar_ganado_entrada_peso_promedio].present?

      cond << "peso_promedio = ?"
      args << params[:form_buscar_ganado_entrada_peso_promedio]

    end

    if params[:form_buscar_ganado_entrada_precio_compra].present?

      cond << "precio_compra = ?"
      args << params[:form_buscar_ganado_entrada_precio_compra]

    end

    if params[:form_buscar_ganado_entrada_proveedor].present?

      cond << "nombre_razon_social ilike ?"
      args << "%#{params[:form_buscar_ganado_entrada_proveedor]}%"

    end

    if params[:form_buscar_ganado_entrada_contacto_proveedor].present?

      cond << "contacto_proveedor ilike ?"
      args << "%#{params[:form_buscar_ganado_entrada_contacto_proveedor]}%"

    end

    if params[:form_buscar_ganado_entrada_telefono_contacto].present?

      cond << "telefono_contacto = ?"
      args << params[:form_buscar_ganado_entrada_telefono_contacto]

    end

    if params[:form_buscar_ganado_entrada_precio_total_compra].present?

      cond << "precio_total_compra = ?"
      args << params[:form_buscar_ganado_entrada_precio_total_compra]

    end

    if params[:form_buscar_ganado_entrada][:tipo_ganado_id].present?

      cond << "tipo_ganado_id = ?"
      args << params[:form_buscar_ganado_entrada][:tipo_ganado_id]

    end

    if params[:form_buscar_ganado_entrada][:raza_ganado_id].present?

      cond << "raza_ganado_id = ?"
      args << params[:form_buscar_ganado_entrada][:raza_ganado_id]

    end

    if params[:form_buscar_ganado_entrada][:etapa_ganado_id].present?

      cond << "etapa_ganado_id = ?"
      args << params[:form_buscar_ganado_entrada][:etapa_ganado_id]

    end

    if params[:form_buscar_ganado_entrada][:sexo_ganado_id].present?

      cond << "sexo_ganado_id = ?"
      args << params[:form_buscar_ganado_entrada][:sexo_ganado_id]

    end

    if params[:form_buscar_ganado_entrada][:tipo_concepcion_id].present?

      cond << "tipo_concepcion_id = ?"
      args << params[:form_buscar_ganado_entrada][:tipo_concepcion_id]

    end

    if params[:form_buscar_ganado_entrada_codigo_lote].present?

      cond << "codigo_lote = ?"
      args << params[:form_buscar_ganado_entrada_codigo_lote]

    end

    if params[:form_buscar_ganado_entrada_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_ganado_entrada_observacion]}%"

    end

    if params[:form_buscar_ganado_entrada][:estado_movimiento_id].present?

      cond << "estado_movimiento_id = ?"
      args << params[:form_buscar_ganado_entrada][:estado_movimiento_id]

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

    if @valido
      
      @ganado_entrada = GanadoEntrada.new()
      @ganado_entrada.procedencia = params[:procedencia]
      @ganado_entrada.peso_promedio = params[:peso_promedio]
      @ganado_entrada.precio_compra = params[:precio_compra].to_s.gsub(/[$.]/,'').to_i
      @ganado_entrada.estado_movimiento_id = PARAMETRO[:estado_movimiento_en_proceso]
      @ganado_entrada.observacion = params[:observacion]
      @ganado_entrada.proveedor_ganado_id = params[:proveedor_id]
      @ganado_entrada.contacto_proveedor = params[:contacto_proveedor].upcase
      @ganado_entrada.telefono_contacto = params[:telefono_contacto]
      @ganado_entrada.sexo_ganado_id = params[:sexo_ganado][:id]
      @ganado_entrada.etapa_ganado_id = params[:etapa_ganado][:id]     
      @ganado_entrada.raza_ganado_id = params[:raza_ganado][:id]
      @ganado_entrada.tipo_concepcion_id = params[:tipo_concepcion][:id]
      @ganado_entrada.codigo_lote = params[:codigo_lote]
      @ganado_entrada.tipo_ganado_id = params[:tipo_ganado][:id]
      @ganado_entrada.cantidad_lote = params[:cantidad_lote]
      @ganado_entrada.precio_total_compra = (params[:cantidad_lote].to_i * params[:precio_compra].to_s.gsub(/[$.]/,'').to_i)

      if @ganado_entrada.save

        auditoria_nueva("registrar entrada de ganado", "ganados_entradas", @ganado_entrada)
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

  def editar_entrada_ganado
    
    @ganado_entrada = GanadoEntrada.find(params[:id])

    respond_to do |f|
      
        f.js
      
    end

  end


  def actualizar_entrada_ganado

    @valido = true
    @msg = ""
    @guardado_ok = false
    contador = 0

    if @valido
      
      @ganado_entrada = GanadoEntrada.where("id = ?", params[:ganado_entrada_id]).first
      @ganado_entrada.procedencia = params[:procedencia].upcase
      @ganado_entrada.peso_promedio = params[:peso_promedio]
      @ganado_entrada.precio_compra = params[:precio_compra].to_s.gsub(/[$.]/,'').to_i
      @ganado_entrada.estado_movimiento_id = PARAMETRO[:estado_movimiento_en_proceso]
      @ganado_entrada.observacion = params[:observacion]
      @ganado_entrada.proveedor_ganado_id = params[:proveedor_id]
      @ganado_entrada.contacto_proveedor = params[:contacto_proveedor].upcase
      @ganado_entrada.telefono_contacto = params[:telefono_contacto]
      @ganado_entrada.sexo_ganado_id = params[:sexo_ganado][:id]
      @ganado_entrada.etapa_ganado_id = params[:etapa_ganado][:id]     
      @ganado_entrada.raza_ganado_id = params[:raza_ganado][:id]
      @ganado_entrada.tipo_concepcion_id = params[:tipo_concepcion][:id]
      @ganado_entrada.codigo_lote = params[:codigo_lote]
      @ganado_entrada.tipo_ganado_id = params[:tipo_ganado][:id]
      @ganado_entrada.cantidad_lote = params[:cantidad_lote]
      @ganado_entrada.precio_total_compra = (params[:cantidad_lote].to_i * params[:precio_compra].to_s.gsub(/[$.]/,'').to_i)

      if @ganado_entrada.save

        auditoria_nueva("registrar entrada de ganado", "ganados_entradas", @ganado_entrada)
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


  def eliminar_entrada_ganado

    @valido = true
    @msg = ""

    @ganado_entrada = GanadoEntrada.find(params[:id])

    @ganado_entrada_elim = @ganado_entrada  

    if @valido

      if @ganado_entrada.destroy

        auditoria_nueva("eliminar entrada de ganado", "ganados_entradas", @ganado_entrada_elim)
        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar la Entrada de Ganado."

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


  def buscar_proveedor
    
    @proveedor = ProveedorGanado.where("nombre_razon_social ilike ?", "%#{params[:proveedor]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @proveedor }
    
    end
    
  end



end