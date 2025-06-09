# Usar una imagen oficial de Node.js como base
FROM node:18-alpine

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copiar los archivos de definición de paquetes e instalar dependencias
# Se copian por separado para aprovechar el cache de Docker
COPY package*.json ./
RUN npm install

# Copiar el resto del código de la aplicación
COPY . .

# Exponer el puerto en el que corre la aplicación
EXPOSE 3000

# El comando para iniciar el servidor
CMD [ "node", "server.js" ] 