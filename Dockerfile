FROM postgres:11

RUN apt-get update

RUN apt-get install -y \
            postgresql-server-dev-11 \
            build-essential \
            guile-2.0-dev \
            guile-2.0-libs

WORKDIR /usr/src/plscheme

COPY . ./

RUN ./install.sh

RUN echo " \
CREATE FUNCTION plschemeu_call_handler() \
  RETURNS language_handler \
  AS '/usr/src/plscheme/plschemeu' LANGUAGE C; \
\
CREATE LANGUAGE plschemeu \
  HANDLER plschemeu_call_handler; \
" >  /docker-entrypoint-initdb.d/init.sql
