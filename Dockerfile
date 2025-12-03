# Dockerfile para aplicación DevOps Python
# Actividad 6.2 - Pipeline de CD a entorno de pruebas

# Etapa 1: Builder (construcción y dependencias)
FROM python:3.11-slim AS builder

# Metadata
LABEL maintainer="mateocl64"
LABEL description="Aplicación DevOps de demostración - Actividad 6.2"
LABEL version="2.0"

# Variables de entorno para Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Crear usuario no-root para seguridad
RUN useradd -m -u 1000 appuser

# Directorio de trabajo
WORKDIR /app

# Copiar solo requirements.txt primero (para aprovechar cache de Docker)
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 2: Runtime (imagen final ligera)
FROM python:3.11-slim

# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_HOME=/app

# Crear usuario no-root
RUN useradd -m -u 1000 appuser

# Directorio de trabajo
WORKDIR $APP_HOME

# Copiar dependencias instaladas desde builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copiar código fuente de la aplicación
COPY --chown=appuser:appuser src/ ./src/

# Crear directorio para logs con permisos
RUN mkdir -p /app/logs && chown -R appuser:appuser /app/logs

# Cambiar a usuario no-root (seguridad)
USER appuser

# Puerto expuesto (si se agrega servidor web en el futuro)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import src.app; print('healthy')" || exit 1

# Comando por defecto
CMD ["python", "src/app.py"]
