FROM mariadb:latest

# Environment variables
ENV MYSQL_ROOT_PASSWORD horse_switch_monopoly_box
ENV MYSQL_DATABASE myDatabase

# Create Database
RUN	mkdir /usr/sql
RUN	chmod 644 /usr/sql

# COPY ["myDatabase.sql", "/usr/sql/sources.sql"]
COPY ./myDatabase.sql /docker-entrypoint-initdb.d/
