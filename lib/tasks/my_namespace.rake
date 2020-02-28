namespace :my_namespace do

  desc "TODO"
  task my_task: :environment do
    
    producciones = VProduccion.where("cobrado = false")
    mes_actual = Time.now.month
    anho_actual = Time.now.year
    @datos_adjuntos = []
    
    

    producciones.each_with_index do |pr, i|

      mes_produccion = pr.fecha_produccion.month
      anho_produccion = pr.fecha_produccion.year

      if mes_produccion <= mes_actual and anho_actual >= anho_produccion

        puts "ya paso mas de un mes sin cobrar"
        
        @datos_adjuntos [i] = pr.produccion_id
        


      end
      puts " "
      puts " "
      puts " "
      puts " "
    end

    #NotificarUsuario.test_email(28936, @datos_adjuntos).deliver

  end

end
