class PagosSalariosController < ApplicationController

before_filter :require_usuario
skip_before_action :verify_authenticity_token

  def index
   

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_pagos_salarios_id].present?

      cond << "pago_salario_id = ?"
      args << params[:form_buscar_pagos_salarios_id]

    end

    if params[:form_buscar_pagos_salarios_fecha].present?

      cond << "fecha = ?"
      args << params[:form_buscar_pagos_salarios_fecha]

    end

    if params[:form_buscar_pagos_salarios][:mes_periodo].present?

      cond << "mes_periodo = ?"
      args << params[:form_buscar_pagos_salarios][:mes_periodo]

    end

    if params[:form_buscar_pagos_salarios_anho_periodo].present?

      cond << "anho_periodo ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_anho_periodo]}%"

    end

    if params[:form_buscar_pagos_salarios][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_pagos_salarios][:hacienda_id]

    end

    if params[:form_buscar_pagos_salarios_total_salario].present?

      cond << "total_salario = ?"
      args << params[:form_buscar_pagos_salarios_total_salario]

    end

    if params[:form_buscar_pagos_salarios_total_adelantos].present?

      cond << "total_adelantos = ?"
      args << params[:form_buscar_pagos_salarios_total_adelantos]

    end

    if params[:form_buscar_pagos_salarios_total_descuentos].present?

      cond << "total_descuentos = ?"
      args << params[:form_buscar_pagos_salarios_total_descuentos]

    end

    if params[:form_buscar_pagos_salarios_total_remuneraciones_extras].present?

      cond << "total_remuneraciones_extras = ?"
      args << params[:form_buscar_pagos_salarios_total_remuneraciones_extras]

    end


    if params[:form_buscar_pagos_salarios_monto_total_pagado].present?

      cond << "monto_total_pagado = ?"
      args << params[:form_buscar_pagos_salarios_monto_total_pagado]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @personales =  VPagoSalario.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPagoSalario.where(cond).count
      
    else

      @personales = VPagoSalario.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPagoSalario.count

    end

    @total_registros = VPagoSalario.count

    respond_to do |f|
      
      f.js
      
    end

  end

  def agregar

    @personal = PagoSalario.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    

    if @valido
      
      @pago_salario = PagoSalario.new()
      

        if @pago_salario.save

          auditoria_nueva("registrar pagos de salarios", "pagos_salarios", @pago_salario)
         
          @guardado_ok = true
         
        end 

    end
  
      
    respond_to do |f|
      
        f.js
      
    end

  end

  def editar
    
    @pago_salario = PagoSalario.find(params[:id])

    respond_to do |f|
      
        f.js
      
  end

  end

  def actualizar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:personal][:nombre].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre. \n"

    end

   

    if @valido
      
      @pago_salario = PagoSalario.where("id = ?", params[:id]).first

      @pago_salario.fecha = params[:personal][:nombre].upcase
      

        if @pago_salario.save

          auditoria_nueva("editar datos de pagos de salarios", "pagos_salarios", @pago_salario)
         
          @actualizado_ok = true
         
        end 

    end  
              
    respond_to do |f|
      
        f.js
      
    end

  end

  def eliminar

    valido = true
    @msg = ""

    @pago_salario = PagoSalario.find(params[:id])

    @pago_salario_elim = @pago_salario  

    if valido

      if @pago_salario.destroy

        auditoria_nueva("eliminar pago de salario", "pagos_salarios", @pago_salario_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el Pago de Salarios."

      end

    end

        
    respond_to do |f|

      f.js

    end

  end

end