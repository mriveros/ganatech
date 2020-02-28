json.array! @usuarios do |usuario|
  
  json.id usuario.id
   
   json.persona do
    
    json.id usuario.persona.id
    json.nombre usuario.persona.nombre_persona

  end
  
end