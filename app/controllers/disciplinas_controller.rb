class DisciplinasController < ApplicationController

	before_filter :require_usuario

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_disciplinas_id].present?

      cond << "disciplinas.id = ?"
      args << params[:form_buscar_disciplinas_id]

    end

    

  
    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @disciplinas =  Disciplina.orden_id.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = Disciplina.where(cond).count

    else

      @disciplinas = Disciplina.orden_id.paginate(per_page: 10, page: params[:page])
      @total_encontrados = Disciplina.count

    end

    @total_registros = Disciplina.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @disciplina = Disciplina.new

    respond_to do |f|
      f.js
    end

  end

  def guardar

    valido = true
    @msg = ""

    
    @disciplina = Disciplina.new(params[:disciplina])

    existe = Disciplina.where("descripcion = ? ", params[:disciplina][:descripcion])
    existe_guarani = Disciplina.where("descripcion_guarani = ? and descripcion_guarani <> ''", params[:disciplina][:descripcion_guarani])

    puts "PRUEBAS DE VALIDADCIONES++++++++++++++++++++++++++++++++"
    puts existe_guarani.present?
    if existe.present? || existe_guarani.present?

      valido = false
      @msg = "Esta disciplina ya existe."
    
    else

      if @disciplina.save

        auditoria_nueva("Guardar Disciplinas", "disciplinas", @disciplina)

        @disciplina_ok = true
        @msg = "Registrado Exitosamente"

      
      end 

    end
 
       
    rescue Exception => exc  
      @msg = exc.message.split(':')
               
    respond_to do |f|

      f.js

    end

  end

  def eliminar

    valido = true
    @msg = ""

    @disciplina = Disciplina.find(params[:id])
    
      if valido

        if @disciplina.destroy

          @eliminado = true
          @msg = "Eliminado Exitosamente."

        else

          @msg = "ERROR: No se ha podido eliminar la Disciplina."

        end

      end

    respond_to do |f|

      f.js

    end

  end

  def editar

    @disciplina = Disciplina.find(params[:id])

    respond_to do |f|

      f.js

    end

  end

  def actualizar

    valido = true
    @msg = ""

    @disciplina = Disciplina.find(params[:disciplina][:id])
    existe = Disciplina.where("descripcion = ? ", params[:disciplina][:descripcion])
    existe_guarani = Disciplina.where("descripcion_guarani = ? and descripcion_guarani <> ''", params[:disciplina][:descripcion_guarani])

    puts "PRUEBAS DE VALIDADCIONES++++++++++++++++++++++++++++++++"
    puts existe_guarani.present?
    if existe.present? || existe_guarani.present?

      valido = false
      @msg = "Esta disciplina ya existe."
    
    else

      @disciplina.descripcion = params[:disciplina][:descripcion]
      @disciplina.descripcion_guarani = params[:disciplina][:descripcion_guarani]

      auditoria_id = auditoria_antes("editar disciplinas", "disciplinas", @disciplina)

      if @disciplina.save
        auditoria_despues(@disciplina, auditoria_id)
        @disciplina_ok = true
        @msg += "Registrado Exitosamente"
        
      end 

    end



    # dispone el mensaje de error 
    #puts "Aqui si muestra el error ".concat(exc.message)
        
    respond_to do |f|

      f.js

    end

  end

end
