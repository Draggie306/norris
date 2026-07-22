# syntax=docker/dockerfile:1

FROM rust:1.97.1-alpine3.24 AS builder

WORKDIR /app

# Norris CI settings -- already uses offline mode SQLx! 
ENV SQLX_OFFLINE=true


COPY . .

RUN cargo build \
    --release \
    --locked



FROM alpine:3.24

WORKDIR /app

COPY --from=builder /app/target/release/norris ./norris

CMD ["./norris"]
