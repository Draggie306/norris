# syntax=docker/dockerfile:1

FROM rust:1.97.1-alpine3.24 AS builder

WORKDIR /app

# Norris CI settings -- already uses offline mode SQLx! 
ENV SQLX_OFFLINE=true


COPY . .

RUN set -eux; \
    cargo build --release --locked; \
    echo "Cargo build completed! Running diagnostics"; \
    ls -lah /app/target/release; \
    echo "Validating build of norris executable"; \
    test -f /app/target/release/norris; \
    test -x /app/target/release/norris; \
    echo "Copying norris executable to safe location"; \
    mkdir -p /out; \
    cp /app/target/release/norris /out/norris; \
    ls -lah /out/norris


FROM alpine:3.24

WORKDIR /app

COPY --from=builder /out/norris ./norris

CMD ["./norris"]
