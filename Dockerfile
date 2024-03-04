# Usamos una imagen de Python oficial como imagen base
# Usar una imagen base oficial de Python como punto de partida
FROM python:3.13.0a3 as builder

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Instalar dependencias
# Copiar solo el archivo de requisitos primero para aprovechar la caché de Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del código fuente del proyecto al contenedor
COPY . .

# Usar multi-stage build para minimizar el tamaño de la imagen y mejorar la seguridad
FROM python:3.13.0a3

WORKDIR /app
COPY --from=builder /app /app

# Crear un usuario no root para ejecutar la aplicación de manera segura
RUN useradd -m myuser
USER myuser

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 8000

# Definir variables de entorno (personalizar según sea necesario)
ENV MY_ENVIRONMENT_VAR=value

# Incluir un comando de chequeo de salud para verificar el estado de la aplicación
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# El comando para ejecutar la aplicación, ajustar según sea necesario
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]