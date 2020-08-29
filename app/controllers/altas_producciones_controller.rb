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
    @guardado_ok = false

                
               
    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

   
        
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

             
        
    respond_to do |f|

      f.js

    end

  end
  

  def buscar_precio

     @alta_produccion = VAltaProduccion.where("ganado_nombre ilike ?", "%#{params[:ganado_nombre]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @alta_produccion }
    
    end

  end

  

  def alta_produccion_detalle

    @alta_produccion_detalle = AltaProduccionDetalle.where("alta_produccion_id = ?", params[:alta_produccion_id])


    respond_to do |f|

      f.js

    end

  end


  def agregar_alta_produccion_detalle

    @alta_produccion_detalle = AltaProduccionDetalle.new

    respond_to do |f|

      f.js
      
    end

  end


  def guardar_alta_produccion_detalle
    @msg = ""
    @valido = true
    @guardado_ok = false


    if @valido

      @alta_produccion_detalle = AltaProduccionDetalle.new
      @alta_produccion_detalle.alta_produccion_id = params[:alta_produccion_id]
      @alta_produccion_detalle.desde_fecha = params[:desde_fecha]
      @alta_produccion_detalle.hasta_fecha = params[:hasta_fecha]
      @alta_produccion_detalle.cantidad_litros = params[:cantidad_litros]
      if @alta_produccion_detalle.save

        @guardado_ok = true

      end

    end


    respond_to do |f|

      f.js
      
    end

  end





end