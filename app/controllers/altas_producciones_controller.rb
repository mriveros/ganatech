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

    @alta_produccion = AltaProduccion.where("id = ?", params[:alta_produccion_id] ).first
    @alta_produccion_detalle = VAltaProduccionDetalle.orden_fecha_creacion.where("alta_produccion_id = ?", params[:alta_produccion_id]).paginate(per_page: 10, page: params[:page])


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
      @alta_produccion_detalle.estado_alta_produccion_detalle_id = PARAMETRO[:estado_alta_produccion_detalle_disponible]
      if @alta_produccion_detalle.save

        @guardado_ok = true

      end

    end


    respond_to do |f|

      f.js
      
    end

  end


  def eliminar_alta_produccion_detalle

    @valido = true
    @msg = ""
    @eliminado = false

    @alta_produccion_detalle = AltaProduccionDetalle.where("id = ?", params[:alta_produccion_detalle_id]).first

    @alta_produccion_detalle_elim = @alta_produccion_detalle  

    if @valido

      if @alta_produccion_detalle.destroy

        auditoria_nueva("eliminar alta produccion detalle", "altas_producciones_detalles", @alta_produccion_detalle_elim)

        @eliminado = true

      end

    end
        
    respond_to do |f|

      f.js

    end

  end


  def marcar_desactivado

    @valido = true
    @msg = ""
    @actualizado_ok = false

    @alta_produccion = AltaProduccion.where("id = ?", params[:alta_produccion_id]).first
    @alta_produccion.estado_alta_produccion_id = PARAMETRO[:estado_alta_produccion_inactiva]
    

    if @alta_produccion.save

      @actualizado_ok = true     

    end
        
    respond_to do |f|

      f.js

    end

  end


  def agregar_produccion_lote

    @lote_produccion_ganado = LoteProduccionGanado.new
    @lote_produccion_ganado.alta_produccion_detalle_id = params[:alta_produccion_detalle_id]
    
    if @lote_produccion_ganado.save

      auditoria_nueva("Guardar Lote para produccion de ganado","tmp_lote_produccion_ganado", @lote_produccion_ganado)

    end

    respond_to do |f|

      f.js

    end

  end

  def eliminar_produccion_lote

    @lote_produccion_ganado = LoteProduccionGanado.where("alta_produccion_detalle_id = ? ", params[:alta_produccion_detalle_id]).first
    aux = @lote_produccion_ganado
    
    if @lote_produccion_ganado.destroy
    
      auditoria_nueva("Eliminar Lote para produccion de ganado","tmp_lote_produccion_ganado", @lote_produccion_ganado)

    end

    respond_to do |f|

      f.js

    end

  end


  def verificar_tabla_temporal

    @estado_lote = 0

    lote_produccion_ganado = LoteProduccionGanado.all
    
    @estado_lote = lote_produccion_ganado
    
    respond_to do |f|
      
      f.html
      f.json { render :json => @estado_lote }

    end

  end


  def agregar_alta_produccion_queso

    @alta_produccion_queso = AltaProduccionQueso.new

    respond_to do |f|

      f.js
      
    end

  end


end