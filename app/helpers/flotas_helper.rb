module FlotasHelper

def link_to_editar_flota(flota)

    render partial: 'link_to_editar_flota', locals: { flota: flota }
    
end
  
end
