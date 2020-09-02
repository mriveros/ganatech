class AltasProduccionesQuesosController < ApplicationController

  before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_alta_produccion_queso_id].present?

      cond << "alta_produccion_queso_id = ?"
      args << params[:form_buscar_alta_produccion_queso_id]

    end

    if params[:form_buscar_alta_produccion_queso_fecha_produccion].present?

      cond << "fecha_produccion = ?"
      args << params[:form_buscar_alta_produccion_queso_fecha_produccion]

    end

    if params[:form_buscar_alta_produccion_queso_periodo].present?

      cond << "periodo ilike ?"
      args << "%#{params[:form_buscar_alta_produccion_queso_periodo]}%"

    end

    if params[:form_buscar_alta_produccion_queso_cantidad_obtenida].present?

      cond << "cantidad_obtenida = ?"
      args << params[:form_buscar_alta_produccion_queso_cantidad_obtenida]

    end

    if params[:form_buscar_alta_produccion_queso_peso_total].present?

      cond << "peso_total = ?"
      args << params[:form_buscar_alta_produccion_queso_peso_total]

    end

    if params[:form_buscar_alta_produccion_queso_cantidad_utilizada].present?

      cond << "cantidad_utilizada = ?"
      args << params[:form_buscar_alta_produccion_queso_cantidad_utilizada]

    end

    
    if params[:form_buscar_alta_produccion_queso][:estado_alta_produccion_queso_id].present?

      cond << "estado_alta_produccion_queso_id = ?"
      args << params[:form_buscar_alta_produccion_queso][:estado_alta_produccion_queso_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @altas_producciones_quesos =  VAltaProduccionQueso.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VAltaProduccionQueso.where(cond).count

    else

      @altas_producciones_quesos = VAltaProduccionQueso.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VAltaProduccionQueso.count

    end

    @total_registros = VAltaProduccionQueso.count

    respond_to do |f|

      f.js

    end

  end

  

  def alta_produccion_queso_detalle

    @alta_produccion_queso = AltaProduccionQueso.where("id = ?", params[:alta_produccion_queso_id] ).first
    @alta_produccion_queso_detalle = VAltaProduccionQuesoDetalle.orden_fecha_creacion.where("alta_produccion_queso_id = ?", params[:alta_produccion_queso_id]).paginate(per_page: 10, page: params[:page])


    respond_to do |f|

      f.js

    end

  end


  def enviar_a_derivados_lacteos

    @valido = true
    @msg = ""
    @actualizado_ok = false

    @alta_produccion = AltaProduccionQueso.where("id = ?", params[:alta_produccion_id]).first
    @alta_produccion.estado_alta_produccion_id = PARAMETRO[:estado_alta_produccion_inactiva]
    
    if @alta_produccion.save

      @actualizado_ok = true     

    end
        
    respond_to do |f|

      f.js

    end

  end



end