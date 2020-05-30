module MedicamentosHelper

def link_to_medicamento_detalle(medicamento)

    render partial: 'link_to_medicamento_detalle', locals: { medicamento: medicamento }
    
end
  
end
