# syntax=docker/dockerfile:1

# HELPER DOCKERFILE for mysql to remove the need to manually mount 
# the init script in the main Norris yml file.
# See https://github.com/Draggie306/norris/issues/9 for more.

FROM mysql:8.0.46

COPY 001-init.sql /docker-entrypoint-initdb.d/001-init.sql