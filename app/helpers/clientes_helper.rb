module ClientesHelper

def link_to_editar_cliente(cliente)

    render partial: 'link_to_editar_cliente', locals: { cliente: cliente }
    
end
  
end
