class DerivadosLacteosController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_derivado_lacteo_id].present?

      cond << "derivado_lacteo_id = ?"
      args << params[:form_buscar_alta_produccion_id]

    end

    

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @derivados_lacteos =  DerivadoLacteo.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = DerivadoLacteo.where(cond).count

    else

      @derivados_lacteos = DerivadoLacteo.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = DerivadoLacteo.count

    end

    @total_registros = DerivadoLacteo.count

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

    alta_produccion_queso = AltaProduccionQuesoDetalle.where("alta_produccion_detalle_id = ? ", params[:alta_produccion_detalle_id]).first
    
    if alta_produccion_queso.present?

      @valido = false
      @msg = "Este detalle fue utilizado para la producción de Quesos"

    end


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


  def guardar_alta_produccion_queso

    @msg = ""
    @guardado_ok = false
    @valido = true
    @cantidad_utilizada = 0

    @lote_produccion_ganado = LoteProduccionGanado.all
    @lote_produccion_ganado.each do |lpg|
      
      alta_produccion_detalle = AltaProduccionDetalle.where("id = ?", lpg.alta_produccion_detalle_id).first
      @cantidad_utilizada = @cantidad_utilizada + alta_produccion_detalle.cantidad_litros
      
    end
    
      
    if @valido

      AltaProduccionQuesoDetalle.transaction do

        @alta_produccion_queso = AltaProduccionQueso.new
        @alta_produccion_queso.fecha_produccion = params[:fecha_produccion]
        @alta_produccion_queso.periodo = Time.now.month.to_s+'-'+Time.now.year.to_s
        @alta_produccion_queso.cantidad_obtenida = params[:cantidad_obtenida]
        @alta_produccion_queso.peso_total = params[:peso_total]
        @alta_produccion_queso.cantidad_utilizada = @cantidad_utilizada
        @alta_produccion_queso.estado_alta_produccion_queso_id = PARAMETRO[:estado_alta_produccion_queso_activa]
        
        if @alta_produccion_queso.save

          auditoria_nueva("Agregar alta produccion queso", "altas_producciones_quesos", @alta_produccion_queso)

          @lote_produccion_ganado.each do |lpg|

            @alta_produccion_queso_detalle = AltaProduccionQuesoDetalle.new
            @alta_produccion_queso_detalle.alta_produccion_queso_id = @alta_produccion_queso.id
            @alta_produccion_queso_detalle.alta_produccion_detalle_id = lpg.alta_produccion_detalle_id
            if @alta_produccion_queso_detalle.save

              alta_produccion_detalle = AltaProduccionDetalle.where("id = ?", lpg.alta_produccion_detalle_id).first
              alta_produccion_detalle.estado_alta_produccion_detalle_id = PARAMETRO[:estado_alta_produccion_detalle_produccion_queso]
              
              if alta_produccion_detalle.save

                @guardado_ok = true

              end

            end

          end #end each

        end

        @lote_produccion_ganado.destroy_all

      end #end Transaction

    end #end valido

    respond_to do |f|

      f.js
      
    end

  end


  def enviar_a_derivados_lacteos

    @valido = true
    @msg = ""
    @guardado_ok = false
    

    if @valido

      DerivadoLacteo.transaction do 

        @produccion_lote_ganado = LoteProduccionGanado.all

        @produccion_lote_ganado.each do |lpg|

          @alta_produccion_detalle = AltaProduccionDetalle.where("id = ?", lpg.alta_produccion_detalle_id).first
          auditoria_id = auditoria_antes("Enviar alta produccion leche a derivados lacteos","altas_producciones_detalles", @alta_produccion_queso )
          @alta_produccion_detalle.estado_alta_produccion_detalle_id = PARAMETRO[:estado_alta_produccion_detalle_produccion_leche]

          if @alta_produccion_detalle.save

            auditoria_despues(@alta_produccion_detalle,auditoria_id)
            @derivados_lacteos_leche = DerivadoLacteo.new
            @derivados_lacteos_leche.tipo_derivado_id = PARAMETRO[:tipo_derivado_leche]
            @derivados_lacteos_leche.alta_produccion_queso_id = nil
            @derivados_lacteos_leche.alta_produccion_id = @alta_produccion_detalle.id
            @derivados_lacteos_leche.cantidad_inicial = @alta_produccion_detalle.cantidad_litros
            @derivados_lacteos_leche.cantidad_actual = @alta_produccion_detalle.cantidad_litros
            @derivados_lacteos_leche.tipo_medicion_id = PARAMETRO[:tipo_medicion_derivado_lacteo_leche]
            @derivados_lacteos_leche.estado_derivado_lacteo_id = PARAMETRO[:estado_derivado_lacteo_disponible]
            if @derivados_lacteos_leche.save

              auditoria_nueva("Agregar produccion de leche a derivados lacteos", "derivados_lacteos", @derivados_lacteos_leche )
              @guardado_ok = true

            end

          end

        end
        

      end #end transaction

      @produccion_lote_ganado.destroy_all

    end
        
    respond_to do |f|

      f.js

    end

  end


end