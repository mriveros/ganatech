class InfoVentasController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_info_ventas_id].present?

      cond << "id = ?"
      args << params[:form_buscar_info_ventas_id]

    end

    if params[:form_buscar_info_ventas_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_info_ventas_fecha]

    end

    if params[:form_buscar_info_ventas_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_info_ventas_descripcion]}%"

    end

    if params[:form_buscar_info_ventas_monto].present?

      cond << "monto = ?"
      args << params[:form_buscar_info_ventas_monto]

    end

    if params[:form_buscar_info_ventas_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_info_ventas_observacion]}%"

    end

    if params[:form_buscar_info_ventas_fecha_desde].present?

      cond << "fecha >= ?"
      args << params[:form_buscar_info_ventas_fecha_desde]

    end

    if params[:form_buscar_info_ventas_fecha_hasta].present?

      cond << "fecha <= ?"
      args << params[:form_buscar_info_ventas_fecha_hasta]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @aux_ventas =  AuxVenta.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxVenta.where(cond).count

    else
     
      @aux_ventas = AuxVenta.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxVenta.count

    end

    @total_registros = AuxVenta.count

    respond_to do |f|
      
     f.js
      
    end

  end

end