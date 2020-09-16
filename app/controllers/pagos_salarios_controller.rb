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

      @personales =  VPersonal.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPersonal.where(cond).count
      
    else

      @personales = VPersonal.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VPersonal.count

    end

    @total_registros = VPersonal.count

    respond_to do |f|
      
      f.js
      
    end

  end

  def agregar

    @personal = Personal.new

    respond_to do |f|
      
        f.js
      
    end

  end

  def guardar

    @valido = true
    @msg = ""
    @guardado_ok = false

    unless params[:personal][:nombre].present?

      @valido = false
      @msg += " Debe Completar el campo Nombre. \n"

    end

    unless params[:personal][:apellido].present?

      @valido = false
      @msg += " Debe Completar el campo Apellido. \n"

    end

    unless params[:personal][:ruc_ci].present?

      @valido = false
      @msg += "Debe Completar el campo con el RUC o CI. \n"

    end

    if @valido
      
      @personal = Personal.new()
      @personal.nombre = params[:personal][:nombre].upcase
      @personal.apellido = params[:personal][:apellido].upcase
      @personal.ruc_ci = params[:personal][:ruc_ci]
      @personal.direccion = params[:personal][:direccion]
      @personal.telefono = params[:personal][:telefono]
      @personal.email = params[:personal][:email]
      @personal.hacienda_id = params[:personal][:hacienda_id]
      @personal.estado_personal_id = params[:personal][:estado_personal_id]
      @personal.cargo_id = params[:personal][:cargo_id]
      @personal.observacion = params[:personal][:observacion]

        if @personal.save

          auditoria_nueva("registrar personal", "personales", @personal)
         
          @guardado_ok = true
         
        end 

    end
  
    rescue Exception => exc  
    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
      if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat(" "+@excep[4].to_s)
      
      end                
              
    respond_to do |f|
      
        f.js
      
    end

  end

  def editar
    
    @personal = Personal.find(params[:id])

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

    unless params[:personal][:apellido].present?

      @valido = false
      @msg += " Debe Completar el campo Apellido. \n"

    end

    unless params[:personal][:ruc_ci].present?

      @valido = false
      @msg += "Debe Completar el campo con el RUC o CI. \n"

    end

    if @valido
      
      @personal = Personal.where("id = ?", params[:personal_id]).first

      @personal.nombre = params[:personal][:nombre].upcase
      @personal.apellido = params[:personal][:apellido].upcase
      @personal.ruc_ci = params[:personal][:ruc_ci]
      @personal.direccion = params[:personal][:direccion]
      @personal.telefono = params[:personal][:telefono]
      @personal.email = params[:personal][:email]
      @personal.hacienda_id = params[:personal][:hacienda_id]
      @personal.estado_personal_id = params[:personal][:estado_personal_id]
      @personal.cargo_id = params[:personal][:cargo_id]
      @personal.observacion = params[:personal][:observacion]

        if @personal.save

          auditoria_nueva("registrar personal", "personales", @personal)
         
          @actualizado_ok = true
         
        end 

    end
  
                
              
    respond_to do |f|
      
        f.js
      
    end

  end

  def buscar_personal
    
    @personas = Personal.where("nombre ilike ?", "%#{params[:personal]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @personas }
    
    end
    
  end

  def eliminar

    valido = true
    @msg = ""

    @personal = Personal.find(params[:id])

    @personal_elim = @personal  

    if valido

      if @personal.destroy

        auditoria_nueva("eliminar personal", "personales", @personal_elim)

        @eliminado = true

      else

        @msg = "ERROR: No se ha podido eliminar el personal."

      end

    end

        
    respond_to do |f|

      f.js

    end

  end

end