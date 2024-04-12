FROM golang AS build
COPY . /src
WORKDIR /src
RUN make

FROM alpine:3.15
RUN mkdir /app

# 复制配置文件
COPY conf /app/conf

# 复制主文件
COPY --from=build /src/rustdesk-api-server /app
WORKDIR /app
ENTRYPOINT ["./rustdesk-api-server"]

# 导出端口号
EXPOSE 21114