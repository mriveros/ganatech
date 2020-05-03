class MedicamentosController < ApplicationController

before_filter :require_usuario

  def index

  end

  def lista

    

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @medicamento = Medicamento.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""
    @flota_ok = false
          
               
    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:id])

    
        
    respond_to do |f|

      f.js

    end

  end

  def editar

    @medicamento = Medicamento.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @medicamento = Medicamento.find(params[:medicamento][:id])
    auditoria_id = auditoria_antes("actualizar flota", "flotas", @flota)


     respond_to do |f|

      f.js

    end

  end


  def buscar_medicamento

    @medicamentos = Medicamento.where("nombre_medicamento ilike ?", "%#{params[:medicamento]}%")

    respond_to do |f|
      
      f.html
      f.json { render :json => @medicamentos }
    
    end

  end


end