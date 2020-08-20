module ProveedoresGanadosHelper

  def link_to_editar_proveedor_ganado(proveedor_ganado)

      render partial: 'link_to_editar_proveedor_ganado', locals: { proveedor_ganado: proveedor_ganado }

  end

end
