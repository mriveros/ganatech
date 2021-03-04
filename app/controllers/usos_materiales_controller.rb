class UsoMaterialController < ApplicationController

before_filter :require_usuario

  def index
  
 
  end 
 
  def lista

    cond = []
    args = []

    if params[:form_buscar_uso_material_id].present?

      cond << "uso_material_id = ?"
      args << params[:form_buscar_uso_material_id]

    end

    if params[:form_buscar_uso_material_codigo].present?

      cond << "codigo_lote = ?"
      args << params[:form_buscar_uso_material_codigo]

    end

    if params[:form_buscar_uso_material_nombre].present?

      cond << "ganado_nombre ilike ?"
      args << "%#{params[:form_buscar_uso_material_nombre]}%"

    end

    if params[:form_buscar_uso_material_ganado_rp].present?

      cond << "ganado_rp  ilike ?"
      args << "%#{params[:form_buscar_uso_material_ganado_rp]}%"

    end

    if params[:form_buscar_uso_material][:tipo_alimentacion_id].present?

      cond << "tipo_alimentacion_id = ?"
      args << params[:form_buscar_uso_material][:tipo_alimentacion_id]

    end

    if params[:form_buscar_uso_material][:alimentacion_id].present?

      cond << "alimentacion_id = ?"
      args << params[:form_buscar_uso_material][:alimentacion_id]

    end

    if params[:form_buscar_uso_material_cantidad_suministrada].present?

      cond << "cantidad_suministrada  = ?"
      args << params[:form_buscar_uso_material_cantidad_suministrada]

    end

    if params[:form_buscar_uso_material_peso].present?

      cond << "peso = ?"
      args << params[:form_buscar_uso_material_peso]

    end

    if params[:form_buscar_uso_material_fecha_control].present?

      cond << "fecha_control = ?"
      args << params[:form_buscar_uso_material_fecha_control]

    end

    if params[:form_buscar_uso_material_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_uso_material_observacion]}%"

    end

    if params[:form_buscar_uso_material][:clasificacion_alimentacion_id].present?

      cond << "clasificacion_alimentacion_id = ?"
      args << params[:form_buscar_uso_material][:clasificacion_alimentacion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @controles_alimentaciones =  VUsoMaterial.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VUsoMaterial.where(cond).count

    else
     
      @controles_alimentaciones = VUsoMaterial.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VUsoMaterial.count

    end

    @total_registros = VUsoMaterial.count

    respond_to do |f|
      
     f.js
      
    end

  end

  def agregar

    @uso_material = UsoMaterial.new
    nuevo_incremento = UsoMaterial.last
    if nuevo_incremento.present?

      @codigo_control = nuevo_incremento.codigo_lote + 1

    else

      @codigo_control = 1

    end
    respond_to do |f|
      
        f.js
      
    end

  end
 
  def guardar

    @valido = true
    @msg = " "
    @guardado_ok = false
    
    if @valido

      if params[:clasificacion_alimentacion][:id].to_i == PARAMETRO[:clasificacion_por_ganado]
        
        @alimentacion = UsoMaterial.new
        @alimentacion.ganado_id = params[:ganado_id]
        @alimentacion.fecha_control = params[:fecha_control]
        @alimentacion.tipo_alimentacion_id = params[:tipo_alimentacion][:id]
        @alimentacion.alimentacion_id = params[:alimentacion_id]
        @alimentacion.cantidad_suministrada = params[:cantidad_suministrada]
        @alimentacion.codigo_lote = params[:codigo_lote]
        @alimentacion.clasificacion_alimentacion_id = params[:clasificacion_alimentacion][:id]
        @alimentacion.observacion = params[:observacion]

        if @alimentacion.save

          @guardado_ok = true

        end

      end

     respond_to do |f|

      f.js

    end
  
  end

 
 def eliminar

    @eliminado = false
    @msg = ""

    @alimentacion = UsoMaterial.where("id = ?", params[:uso_material_id]).first
    @alimentacion_elim = @alimentacion
    
    if @alimentacion.destroy
    
      @eliminado = true

    end
    
    respond_to do |f|

      f.js

    end

  end

end