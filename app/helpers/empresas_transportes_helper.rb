module EmpresasTransportesHelper

  def link_to_editar_empresa_transporte(empresa_transporte)

      render partial: 'link_to_editar_empresa_transporte', locals: { empresa_transporte: empresa_transporte }

  end

end
