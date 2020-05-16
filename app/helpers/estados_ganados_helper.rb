module EstadosGanadosHelper

  def link_to_editar_estado_ganado(estado_ganado)

      render partial: 'link_to_editar_estado_ganado', locals: { estado_ganado: estado_ganado }

  end

end
