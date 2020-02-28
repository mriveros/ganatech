class JurisdiccionesController < ApplicationController

  def index

    if params[:departamento_id]
      
      @jurisdicciones = Jurisdiccion.where("departamento_id = ? and estado = true", params[:departamento_id])
    
    end

    respond_to do |f|
      
      f.json { render :json => @jurisdicciones }
    
    end
  
  end
  def buscar_juridisccion_oferta
      if params[:departamento_id]
           if current_usuario.perfil_actual.rol_id == PARAMETRO[:rol_director]      
              @jurisdicciones = Jurisdiccion.where("departamento_id = ? and estado = true and id in(select distinct on(distrito_id) distrito_id from v_ofertas_educativas WHERE (oferta_educativa_id in(select oferta_educativa_id from usuarios_ofertas_educativas where usuario_id=?)))", params[:departamento_id],current_usuario.id)             
           else
             @jurisdicciones = Jurisdiccion.where("departamento_id = ? and estado = true", params[:departamento_id])
           end
    
      end

    respond_to do |f|
      
      f.json { render :json => @jurisdicciones }
    
    end
  end
end
