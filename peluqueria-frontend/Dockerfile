# 1. Usamos una imagen de Node ligera para construir la app
FROM node:20-alpine

# 2. Creamos la carpeta de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiamos los archivos de configuración de dependencias
COPY package*.json ./

# 4. Instalamos las librerías (esto puede tardar un poco la primera vez)
RUN npm install

# 5. Copiamos el resto del código del proyecto
COPY . .

# 6. Exponemos el puerto que usa Angular por defecto
EXPOSE 4200

# 7. Arrancamos la aplicación. 
# IMPORTANTE: El host 0.0.0.0 permite que Windows vea lo que pasa dentro de Docker
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--poll", "2000"]