# Etapa de construção
FROM golang:latest as builder

RUN apt-get update && apt-get install -y upx

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /go/src/app

# Copiar o código-fonte para o contêiner
COPY . .

# Compilar o aplicativo Go com otimizações
RUN go build -ldflags "-s -w" -o main .

# Comprimir o binário usando UPX
RUN upx --best --lzma main

# Iniciar uma nova etapa a partir do zero
FROM busybox:musl

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /root/

# Copiar o binário pré-compilado da etapa anterior
COPY --from=builder /go/src/app/main .

# Comando para executar o binário
CMD ["./main"]
