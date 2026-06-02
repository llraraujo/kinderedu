# Etapa 1: build da aplicação Flutter
FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ARG http_proxy
ARG https_proxy
ARG no_proxy

ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV NO_PROXY=${NO_PROXY}
ENV http_proxy=${http_proxy}
ENV https_proxy=${https_proxy}
ENV no_proxy=${no_proxy}


WORKDIR /app

# Copia os arquivos de dependências primeiro para aproveitar cache
COPY pubspec.yaml pubspec.lock ./

RUN flutter pub get

# Copia o restante do projeto
COPY . .

# Garante suporte ao Flutter Web
RUN flutter config --enable-web

# Gera o build web em modo release
RUN flutter build web --release

# Etapa 2: servidor Nginx para servir a aplicação
FROM nginx:stable-alpine3.23-perl

# Remove arquivos padrão do Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia o build web gerado pelo Flutter
COPY --from=build /app/build/web /usr/share/nginx/html

# Expõe a porta padrão do Nginx
EXPOSE 80

# Inicia o Nginx
CMD ["nginx", "-g", "daemon off;"]