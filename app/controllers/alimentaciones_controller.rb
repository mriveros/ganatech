class AlimentacionesController < ApplicationController

before_filter :require_usuario

  def index

  end

  def lista

    

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @alimento = Alimentacion.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""
    @alimento_ok = false
          
               
    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @alimento = Alimentacion.find(params[:id])

    
        
    respond_to do |f|

      f.js

    end

  end

  def editar

    @alimento = Alimentacion.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @alimento = Alimentacion.find(params[:alimento][:id])
    auditoria_id = auditoria_antes("actualizar alimento", "alimentos", @alimento)


     respond_to do |f|

      f.js

    end

  end


  def buscar_alimentacion

    if params[:tipo_alimentacion].present?
      
      @alimentaciones = Alimentacion.where("nombre_alimento ilike ? and tipo_alimentacion_id = ?", "%#{params[:alimentacion]}%", params[:tipo_alimentacion])

    end

    respond_to do |f|
      
      f.html
      f.json { render :json => @alimentaciones }
    
    end

  end


end