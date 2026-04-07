FROM alpine:3.23.3

ARG PB_VERSION=0.36.7

RUN apk add --no-cache \
    unzip \
    ca-certificates \
    tzdata \
    curl

WORKDIR /pb

ENV PB_DATA_DIR=/pb/pb_data \
    PB_PUBLIC_DIR=/pb/pb_public \
    PB_HTTP_ADDR=0.0.0.0:8090

ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && \
    rm /tmp/pb.zip && \
    chmod +x /pb/pocketbase

RUN mkdir -p /pb/pb_data /pb/pb_public /pb/pb_hooks

COPY docker/pb/entrypoint.sh /pb/entrypoint.sh
RUN chmod +x /pb/entrypoint.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8090/api/health || exit 1

EXPOSE 8090

ENTRYPOINT ["/pb/entrypoint.sh"]

CMD ["serve"]