class InfoComprasController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_info_compras_id].present?

      cond << "id = ?"
      args << params[:form_buscar_info_compras_id]

    end

    if params[:form_buscar_info_compras_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_info_compras_fecha]

    end
  
    if params[:form_buscar_info_compras_descripcion].present?

      cond << "descripcion ilike ?"
      args << "%#{params[:form_buscar_info_compras_descripcion]}%"

    end

    if params[:form_buscar_info_compras_monto].present?

      cond << "monto = ?"
      args << params[:form_buscar_info_compras_monto]

    end

    if params[:form_buscar_info_compras_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_info_compras_observacion]}%"

    end

    if params[:form_buscar_info_compras_fecha_desde].present?

      cond << "fecha >= ?"
      args << params[:form_buscar_info_compras_fecha_desde]

    end

    if params[:form_buscar_info_compras_fecha_hasta].present?

      cond << "fecha <= ?"
      args << params[:form_buscar_info_compras_fecha_hasta]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @aux_compras =  AuxCompra.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxCompra.where(cond).count

    else
     
      @aux_compras = AuxCompra.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = AuxCompra.count

    end

    @total_registros = AuxCompra.count

    respond_to do |f|
      
     f.js
      
    end

  end

end