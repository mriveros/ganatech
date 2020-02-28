## Para instalar la tipografía la deben copiar a su carpeta local "/usr/share/fonts/".
## Luego deben aplicarle el permiso 777 al archivo, y asignarle al grupo root. Ejemplo

sudo cp /home/nombre_usuario/Descargas/ShelleyAllegroBT.ttf /usr/share/fonts/
sudo chmod 777 /usr/share/fonts/ShelleyAllegroBT.ttf
sudo chown root:root /usr/share/fonts/ShelleyAllegroBT.ttf
sudo fc-cache -f -v

## en caso de que alguna aplicacion java no reconozca las fuentes cargadas
## en ubuntu (instalacion por defecto)
sudo cp /home/nombre_usuario/Descargas/*.ttf /usr/lib/jvm/java-8-oracle/jre/lib/fonts
sudo chmod 777 /usr/lib/jvm/java-8-oracle/jre/lib/fonts/*.ttf

