FROM ubuntu:14.04
MAINTAINER daka
ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        postgresql-9.3


# Copy scripts to container
COPY config/elearningdb-dump.sql /tmp/elearningdb-dump.sql
USER postgres


# Start postgres service
# Create database 'elearningdb'
# Create user root and euser
RUN service postgresql restart && sleep 10 && \
    createdb -O postgres elearningdb && \
    createuser -s -e root && \
    createuser -e -N euser -P


# Import dump and execute upgrade scripts
RUN service postgresql restart && sleep 10 && \
    cd /tmp && \
    psql -w -d elearningdb -U postgres -f /tmp/elearningdb-dump.sql && \
    echo "Completed database init"
USER root


# Expose the PostgreSQL port
EXPOSE 5432


# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql/", "/var/lib/postgresql"]


# Set the default command to run when starting the container
CMD service postgresql restart && tail -f /var/log/postgresql/postgresql-9.3-main.log