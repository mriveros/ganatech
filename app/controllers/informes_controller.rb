class InformesController < ApplicationController

	before_filter :require_usuario

  def indexa
  	cond = []
    args = []

  	@informe = "informes"
  	@msg = "" 
    
    if params[:flota_id].present?

      cond << "flota_id = ?"
      args << params[:flota_id]

    end

    if params[:chofer_id].present?

      cond << "chofer_id = ?"
      args << params[:chofer_id]

    end

    if params[:cliente_id].present?

      cond << "cliente_id = ?"
      args << params[:cliente_id]

    end

    if params[:fecha_desde].present? && params[:fecha_hasta].present? 

      cond << "fecha_produccion >= '#{params[:fecha_desde]}' and fecha_produccion <= '#{params[:fecha_hasta]}'" 

    elsif params[:fecha_desde].present?
      
      cond << "fecha_produccion >= ?"
      args << params[:fecha_desde]

    elsif params[:fecha_hasta].present?
      
      cond << "fecha_produccion <= ?"
      args << params[:fecha_hasta]

    end

    if params[:general].present?

      puts "se generará informe general"

    else

      if params[:cobrado].present?

        cond << "cobrado = ?"
        args << true

      else

        cond << "cobrado = ?"
        args << false

      end

      if params[:pertenece].present?

        cond << "pertenece = ?"
        args << true

      else

        cond << "pertenece = ?"
        args << false
      
      end

    end

    if params[:form_buscar_produccion][:estado_produccion_id].present?

      cond << "estado_produccion_id = ?"
      args << params[:form_buscar_produccion][:estado_produccion_id]

    end


    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0
     
      @produccion =  VProduccion.where(cond).orden_01.paginate(per_page: 10, page: params[:page])

    else

      @produccion = VProduccion.orden_01.paginate(per_page: 10, page: params[:page])
     
    end

    @parametros = { format: :pdf, produccion_id: @produccion.map(&:produccion_id), flota_id: params[:flota_id], chofer_id: params[:chofer_id], cliente_id: params[:cliente_id], fecha_desde: params[:fecha_desde], fecha_hasta: params[:fecha_hasta], pertenece: params[:pertenece], cobrado: params[:cobrado], estado_produccion_id: params[:form_buscar_produccion][:estado_produccion_id] }

    respond_to do |f|

      f.js

    end

  end

  def generar_pdf
    
    
   @produccion =  VProduccion.where("produccion_id in (?)", params[:produccion_id]).orden_01.paginate(per_page: 10, page: params[:page])
    

    respond_to do |f|
     
      f.pdf do

          render  :pdf => "planilla_resumen_produccion_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'informes/planilla_resumen_produccion.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "informes/cabecera_planilla_resumen_produccion.pdf.erb" ,
                  :locals   => { :produccion => @produccion }}},
                  :margin => {:top => 65,                         # default 10 (mm)
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Landscape',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }
      end
      
    end

  end

end


