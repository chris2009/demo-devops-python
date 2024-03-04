# Usamos una imagen de Python oficial como imagen base
FROM python:3.13.0a3

# Establecemos un directorio de trabajo
WORKDIR /app

# Instalamos dependencias del sistema necesarias
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev=13.14-0+deb11u1 \
    gcc=4:10.2.1-1 \
&& rm -rf /var/lib/apt/lists/*

# Copiamos los requisitos de Python y los instalamos
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el proyecto Django al directorio de trabajo en el contenedor
COPY . /app

# Establecemos variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Puerto en el que la aplicación estará disponible
EXPOSE 8000

# Chequeo de salud para verificar que la aplicación esté corriendo correctamente
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost:8000/health || exit 1

# Ejecutamos la aplicación Django
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "demo.wsgi:application"]