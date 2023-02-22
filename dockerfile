FROM debian:latest

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# RUN curl -L -o ammc.zip 'https://firebasestorage.googleapis.com/v0/b/ammc-fa122.appspot.com/o/ammc-v6.2.2.zip?alt=media&token=677225f5-09f1-4df2-b331-a9f244ecd1af' \
#     && unzip ammc.zip -d /ammc \
#     && rm ammc.zip \
#     && chmod +x /ammc/mac-m1/ammc-amb

copy ammc-v6.2.2.zip /ammc.zip
RUN unzip ammc.zip -d /ammc \
    && rm ammc.zip \
    && chmod +x /ammc/linux64/ammc-amb

ENV ARGS="-t -a -w 8123"

CMD ["/ammc/linux64/ammc-amb ", $ARGS]

