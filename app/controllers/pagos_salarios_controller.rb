class PagosSalariosController < ApplicationController

before_filter :require_usuario
skip_before_action :verify_authenticity_token

  def index
   

  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_pagos_salarios_id].present?

      cond << "personal_id = ?"
      args << params[:form_buscar_pagos_salarios_id]

    end

    if params[:form_buscar_pagos_salarios_ruc_ci].present?

      cond << "ruc_ci = ?"
      args << params[:form_buscar_pagos_salarios_ruc_ci]

    end

    if params[:form_buscar_pagos_salarios_nombre].present?

      cond << "nombre ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_nombre]}%"

    end

    if params[:form_buscar_pagos_salarios_apellido].present?

      cond << "apellido ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_apellido]}%"

    end

    if params[:form_buscar_pagos_salarios_direccion].present?

      cond << "direccion ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_direccion]}%"

    end

    if params[:form_buscar_pagos_salarios_email].present?

      cond << "email ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_email]}%"

    end

    if params[:form_buscar_pagos_salarios_telefono].present?

      cond << "telefono ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_telefono]}%"

    end

    if params[:form_buscar_pagos_salarios][:cargo_id].present?

      cond << "cargo_id = ?"
      args << params[:form_buscar_pagos_salarios][:cargo_id]

    end

    if params[:form_buscar_pagos_salarios][:estado_personal_id].present?

      cond << "estado_personal_id = ?"
      args << params[:form_buscar_pagos_salarios][:estado_personal_id]

    end

    if params[:form_buscar_pagos_salarios][:hacienda_id].present?

      cond << "hacienda_id = ?"
      args << params[:form_buscar_pagos_salarios][:hacienda_id]

    end

     if params[:form_buscar_pagos_salarios_sueldo].present?

      cond << "sueldo = ?"
      args << params[:form_buscar_pagos_salarios_sueldo].to_s.gsub(/[$.]/,'').to_i

    end

    if params[:form_buscar_pagos_salarios_observacion].present?

      cond << "observacion ilike ?"
      args << "%#{params[:form_buscar_pagos_salarios_observacion]}%"

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