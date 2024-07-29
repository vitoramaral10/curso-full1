# Etapa de construção
FROM golang:latest as builder

# Instalar dependências
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y xz-utils

# Baixar e instalar o UPX manualmente
RUN wget https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-amd64_linux.tar.xz && \
    tar -xf upx-4.0.2-amd64_linux.tar.xz && \
    mv upx-4.0.2-amd64_linux/upx /usr/local/bin/ && \
    rm -rf upx-4.0.2-amd64_linux*

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /go/src/app

# Copiar o código-fonte para o contêiner
COPY . .

# Compilar o aplicativo Go com otimizações
RUN go build -ldflags "-s -w" -o main .

# Comprimir o binário usando UPX
RUN upx --best --lzma main

# Iniciar uma nova
