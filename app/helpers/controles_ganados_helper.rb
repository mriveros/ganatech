module ControlesGanadosHelper

  def verificar_ganado_lote(ganado_id)

      lote_control_ganado = LoteControlGanado.where("ganado_id = ?", ganado_id).first
      return (lote_control_ganado.present?)? true : false
      
  end
  
end