FROM golang:1.21-alpine AS build
WORKDIR /app
COPY server/go.* ./
RUN go mod download
COPY server/ .
RUN go build -o /calc-server main.go

FROM gcr.io/distroless/base-debian12
COPY --from=build /calc-server /calc-server
ENTRYPOINT ["/calc-server"]