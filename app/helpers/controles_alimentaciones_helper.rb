module ControlesAlimentacionesHelper

  def verificar_ganado_lote_alimentacion(ganado_id)

      lote_control_alimentacion = LoteControlAlimentacion.where("ganado_id = ?", ganado_id).first
      return (lote_control_alimentacion.present?)? true : false
      
  end
  
end