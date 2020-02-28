class ProduccionController < ApplicationController

	before_filter :require_usuario
 

  def index
  end

  def lista

    cond = []
    args = []

    if params[:form_buscar_produccion_id].present?

      cond << "produccion_id = ?"
      args << params[:form_buscar_produccion_id]

    end

     if params[:form_buscar_produccion_codigo].present?

      cond << "codigo_produccion = ?"
      args << params[:form_buscar_produccion_codigo]

    end

    if params[:form_buscar_produccion_cliente].present?

      cond << "cliente_nombre ilike ?"
      args << "%#{params[:form_buscar_produccion_cliente]}%"

    end

    if params[:form_buscar_produccion_fecha].present?

      cond << "fecha_produccion = ?"
      args << params[:form_buscar_produccion_fecha]

    end

    if params[:form_buscar_produccion_chofer].present?

      cond << "nombre_chofer ilike ?"
      args << "%#{params[:form_buscar_produccion_chofer]}%"

    end

    if params[:form_buscar_produccion_codigo_flota].present?

      cond << "codigo_flota = ?"
      args << params[:form_buscar_produccion_codigo_flota]

    end

    if params[:form_buscar_produccion_destino].present?

      cond << "destino ilike ?"
      args << "%#{params[:form_buscar_produccion_destino]}%"

    end

    if params[:form_buscar_produccion_origen].present?

      cond << "origen ilike ?"
      args << "%#{params[:form_buscar_produccion_origen]}%"

    end

    if params[:form_buscar_produccion_destino_final].present?

      cond << "destino_final ilike ?"
      args << "%#{params[:form_buscar_produccion_destino_final]}%"

    end

    if params[:form_buscar_produccion_cobrado].present?
      
      if params[:form_buscar_produccion_cobrado] == "cobrado"
        cond << "cobrado  = ?"
        args << "true"
     
      else

        cond << "cobrado  = ?"
        args << "false"
      
      end


    end

    if params[:form_buscar_produccion_pertenece].present?
      
      if params[:form_buscar_produccion_pertenece] == "propio"

        cond << "pertenece  = ?"
        args << "true"
     
      else

        cond << "pertenece  = ?"
        args << "false"
      
      end


    end

    if params[:form_buscar_produccion][:estado_produccion_id].present?

      cond << "estado_produccion_id = ?"
      args << params[:form_buscar_produccion][:estado_produccion_id]

    end

    cond = cond.join(" and ").lines.to_a + args if cond.size > 0

    if cond.size > 0

      @produccion =  VProduccion.orden_01.where(cond).paginate(per_page: 10, page: params[:page])
      @total_encontrados = VProduccion.where(cond).count

    else
  
      @produccion = VProduccion.orden_01.paginate(per_page: 10, page: params[:page])
      @total_encontrados = VProduccion.count

    end

    @total_registros = VProduccion.count

    respond_to do |f|

      f.js

    end

  end

  def agregar

    @produccion = Produccion.new
    puts "/////////////////////////"
    puts "rutina autonumerico"
    puts'//////////////////////////'
    ultima_produccion = Produccion.order("created_at").last

    if ultima_produccion.present?

      if ultima_produccion.created_at.month != Time.now.month

        @nuevo_autoincremento = 1

      else

         @nuevo_autoincremento = ultima_produccion.codigo_produccion + 1 

      end 

    else
      
      @nuevo_autoincremento = 1

    end
      

    respond_to do |f|

      f.js

    end

  end

 
  def guardar

    @valido = true
    @guardado_ok = false
    @mensaje= ''

    if params[:codigo_produccion].present?

      @produccion = Produccion.where("codigo_produccion = ? and fecha_produccion = now()", params[:codigo_produccion])
    
    end
    
    if @produccion.present?

      @valido = false
      @mensaje = 'Este codigo de producción ya existe en este mes.\n '

    end

    unless params[:codigo_produccion].present?
      
      @valido = false
      @mensaje += 'Debe agregar un código de Producción. \n'

    end

    unless params[:fecha_produccion].present?
      
      @valido = false
      @mensaje += 'Debe agregar una fecha de Producción. \n'

    end

    #unless params[:gasoil_actual].present?
      
    #  @valido = false
    #  @mensaje += 'Se debe cargar la cantidad de combustible actual de la Flota. \n'

    #end

    unless params[:flota_id].present?
      
      @valido = false
      @mensaje += 'Debe seleccionar una Flota para la Producción. \n'

    end

    unless params[:chofer_id].present?
      
      @valido = false
      @mensaje += 'Debe seleccionar un Chofer para realizar la Producción. \n'

    end

    unless params[:destino].present?
      
      @valido = false
      @mensaje += 'Se debe cargar el destino de la Flota. \n'

    end

    unless params[:cliente_id].present?
      
      @valido = false
      @mensaje += 'Debe seleccionar un Cliente. \n'

    end

    unless params[:costo].present?
      
      @valido = false
      @mensaje += 'Es necesario cargar el costo de la Producción. \n'

    end

    if @valido

      @produccion = Produccion.new
      @produccion.codigo_produccion = params[:codigo_produccion]
      @produccion.fecha_produccion = params[:fecha_produccion]
      @produccion.persona_id = params[:chofer_id]
      @produccion.origen = params[:origen]
      @produccion.destino = params[:destino]
      @produccion.destino_final = params[:destino_final]
      @produccion.gasoil_actual = params[:gasoil_actual]
      @produccion.cliente_id = params[:cliente_id]
      @produccion.observaciones = params[:observaciones]
      @produccion.costo = params[:costo].to_s.gsub(/[$.]/,'').to_i
      @produccion.estado_produccion_id = PARAMETRO[:estado_produccion_solicitado]
      if params[:cobrado].present?
        
        @produccion.cobrado = params[:cobrado]
        @produccion.fecha_cobro = params[:fecha_produccion]

      else
      
        @produccion.cobrado = false

      end

      if params[:pertenece].present?

        @produccion.pertenece = params[:pertenece]
      
      else

        @produccion.pertenece = false

      end

      @produccion.flota_id = params[:flota_id]
      
      if @produccion.save
        
        @guardado_ok = true
        @mensaje= 'Producción guardado exitosamente!'
        auditoria_nueva("registrar produccion", "producciones", @produccion)

      end

    end

    respond_to do |f|

      f.js

    end

  end

 def eliminar

    valido = true
    @msg = ""
    @produccion = Produccion.where("id = ?", params[:id]).first
    @produccion_elim = @produccion

    if valido

      if @produccion.destroy

        auditoria_nueva("eliminar produccion", "producciones", @produccion_elim)
         @msg += "Producción eliminada Exitosamente!"
        @eliminado = true

      else

        @msg += "ERROR No se ha podido eliminar la Producción."

      end

    end

    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?

          @excep = exc.message.split(':')    
          @msg = @excep[3].concat( " " + @excep[4].to_s)
          @eliminado = false
        
    end
        
    respond_to do |f|

      f.js

    end

  end


  def produccion_detalle_credito

    @produccion_detalle_credito = VProduccionDetalleCredito.where('produccion_id = ?', params[:produccion_id])

    respond_to do |f|

        f.js

    end

  end

  def produccion_detalle_debito

      @produccion_detalle_debito = VProduccionDetalleDebito.where('produccion_id = ?', params[:produccion_id])

    respond_to do |f|

        f.js

    end

  end

  def agregar_detalle_credito

    @produccion_detalle_credito = ProduccionDetalleCredito.new
   

    respond_to do |f|

        f.js

    end

  end

  def guardar_detalle_credito
    
    @msg = ""
    @guardado_ok = false
    @produccion_detalle_credito = ProduccionDetalleCredito.new
    @produccion_detalle_credito.detalle_credito_id = params[:detalle_credito][:id]
    @produccion_detalle_credito.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
    @produccion_detalle_credito.fecha = params[:fecha]
    @produccion_detalle_credito.produccion_id = params[:produccion_id]

    if @produccion_detalle_credito.save

      @guardado_ok = true
      @msg = "Detalle de Crédito agregado exitosamente!"
      auditoria_nueva("guardar detalles de creditos en produccion", "producciones_detalles_creditos", @produccion_detalle_credito)

    end

     rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end

  end

  def agregar_detalle_debito

    @produccion_detalle_debito = ProduccionDetalleDebito.new

    respond_to do |f|

        f.js

    end

  end

  def guardar_detalle_debito

    @msg = ""
    @guardado_ok = false

    @produccion_detalle_debito = ProduccionDetalleDebito.new
    @produccion_detalle_debito.detalle_debito_id = params[:detalle_debito][:id]
    @produccion_detalle_debito.monto = params[:monto].to_s.gsub(/[$.]/,'').to_i
    @produccion_detalle_debito.fecha = params[:fecha]
    @produccion_detalle_debito.produccion_id = params[:produccion_id]

    if @produccion_detalle_debito.save

      @guardado_ok = true
      @msg = "Detalle de Débito agregado exitosamente!"
      auditoria_nueva("guardar detalles de debitos en produccion", "producciones_detalles_debitos", @produccion_detalle_debito)

    end

    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end

  end


  def eliminar_produccion_detalle_credito

    @msg = ""
    @eliminado = false

    produccion = ProduccionDetalleCredito.where("id = ?", params[:id]).first
    @produccion_elim = produccion
    @produccion_id = produccion.produccion_id

    if produccion.destroy

      @msg = 'Detalle de Producción eliminado exitosamente!'
      @eliminado = true
      auditoria_nueva("eliminar detalles de creditos en produccion", "producciones_detalles_creditos", @produccion_elim)

    else

      @msg = 'No se pudo eliminar el detalle de Producción!'

    end

    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end


  end

  def eliminar_produccion_detalle_debito

    @msg = ""
    @eliminado = false

    produccion = ProduccionDetalleDebito.where("id = ?", params[:id]).first
    @produccion_elim = produccion
    @produccion_id = produccion.produccion_id

    if produccion.destroy

      @msg = 'Detalle de Producción eliminado exitosamente!'
      @eliminado = true
      auditoria_nueva("eliminar detalles de debitos en produccion", "producciones_detalles_debitos", @produccion_elim)

    else

      @msg = 'No se pudo eliminar el detalle de Producción!'

    end

    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|
      
        f.js

    end
    

  end


  def cambiar_estado_solicitado_a_en_progreso

    @msg = ""
    @actualizado = false
    @produccion = Produccion.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("cambiar estado produccion de solicitado a en progreso ", "producciones", @produccion)

    if @produccion.present?

      @produccion.estado_produccion_id = PARAMETRO[:estado_produccion_en_progreso]

      if @produccion.save
      
        @msg = "Estado Producción modificado exitosamente!"
        @actualizado = true
        auditoria_despues(@produccion, auditoria_id)

      end

    else

      @msg = "No se pudo realizar la modificación del estado de la Producción"

    end
    
    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end

  end

  def cambiar_estado_cobro

    @msg = ""
    @actualizado = false
    @produccion = Produccion.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("cambiar estado cobro ", "producciones", @produccion)

    if @produccion.present?

      @produccion.cobrado = true
      @produccion.fecha_cobro = DateTime.now.to_date

      if @produccion.save
      
        @msg += "Estado de Cobro modificado exitosamente!"
        @actualizado = true
        auditoria_despues(@produccion, auditoria_id)

      end

    else

      @msg += "No se pudo realizar la modificación del estado de Cobro de la Producción"

    end
    
    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end


  end


  def cambiar_estado_cobro_desconfirmar

    @msg = ""
    @actualizado = false
    @produccion = Produccion.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("cambiar estado cobro desconfirmar", "producciones", @produccion)

    if @produccion.present?

      @produccion.cobrado = false
      @produccion.fecha_desconfirmar_cobro = DateTime.now.to_date

      if @produccion.save
      
        @msg += "Estado de Cobro modificado exitosamente!"
        @actualizado = true
        auditoria_despues(@produccion, auditoria_id)

      end

    else

      @msg += "No se pudo realizar la modificación del estado de Cobro de la Producción"

    end
    
    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end


  end


  def cambiar_estado_en_progreso_a_finalizado

    @msg = ""
    @actualizado = false
    @produccion = Produccion.where("id = ?", params[:id]).first
    auditoria_id = auditoria_antes("cambiar estado produccion de en progreso a finalizado", "producciones", @produccion)

    if @produccion.present?

      @produccion.estado_produccion_id = PARAMETRO[:estado_produccion_finalizado]

      if @produccion.save
      
        @msg += "Estado Producción modificado exitosamente!"
        @actualizado = true
        auditoria_despues(@produccion, auditoria_id)

      end

    else

      @msg += "No se pudo realizar la modificación del estado de la Producción"

    end
    
    rescue Exception => exc  
        
        # dispone el mensaje de error 
        #puts "Aqui si muestra el error ".concat(exc.message)
        if exc.present?        
        @excep = exc.message.split(':')    
        @msg = @excep[3].concat( " " + @excep[4].to_s)
        @eliminado = false
        
    end

    respond_to do |f|

        f.js

    end

  end

  def planilla_resumen_produccion

    @msg = ""
    @valido = true
    @imprimir = false
    @produccion = Produccion.where("id = ?", params[:produccion_id]).first

    if params[:fecha_impresion].present?

      @imprimir = true
      @parametros = { format: :pdf, produccion_id: @produccion.id }

    end
    
    
    respond_to do |f|

      f.js

    end

  end

  def planilla_resumen_produccion_cliente

    @msg = ""
    @valido = true
    @imprimir = false
    @produccion = Produccion.where("id = ?", params[:produccion_id]).first

    if params[:fecha_impresion].present?

      @imprimir = true
      @parametros = { format: :pdf, produccion_id: @produccion.id }

    end
    
    
    respond_to do |f|

      f.js

    end

  end

  #GENERAR PDF
  def planilla_resumen_produccion_pdf
    

    @produccion = VProduccion.where("produccion_id = ?", params[:produccion_id]).first

    respond_to do |f|
     
      f.pdf do
          render  :pdf => "planilla_resumen_produccion_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'produccion/planilla_resumen_produccion.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "produccion/cabecera_planilla_resumen_produccion.pdf.erb" ,
                  :locals   => { :produccion => @produccion }}},
                  :margin => {:top => 65,                         # default 10 (mm)
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Portrait',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }
      end
      
    end

  end

  #GENERAR PDF CLIENTE
  def planilla_resumen_produccion_cliente_pdf
    

    @produccion = VProduccion.where("produccion_id = ?", params[:produccion_id]).first

    respond_to do |f|
     
      f.pdf do
          render  :pdf => "planilla_resumen_produccion_#{Time.now.strftime("%Y_%m_%d__%H_%M")}",
                  :template => 'produccion/planilla_resumen_produccion_cliente.pdf.erb',
                  :layout => 'pdf.html',
                  :header => {:html => { :template => "produccion/cabecera_planilla_resumen_produccion_cliente.pdf.erb" ,
                  :locals   => { :produccion => @produccion }}},
                  :margin => {:top => 65,                         # default 10 (mm)
                  :bottom => 11,
                  :left => 3,
                  :right => 3},
                  :orientation => 'Portrait',
                  :page_size => "A4",
                  :footer => { :html => {:template => 'layouts/footer.pdf' },
                  :spacing => 1,
                  :line => true }
      end
      
    end

  end

end
