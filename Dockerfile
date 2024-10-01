# Usar la imagen oficial de PostgreSQL
FROM postgres:latest

# Copiar los scripts SQL al contenedor
COPY BaseDeDatos/bdClinica.sql /docker-entrypoint-initdb.d/
COPY BaseDeDatos/funcioneswt.sql /docker-entrypoint-initdb.d/

# Establecer variables de entorno para la base de datos
ENV POSTGRES_DB=clinica
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123
