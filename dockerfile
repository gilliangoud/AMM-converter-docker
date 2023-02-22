FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

copy ammc-v6.2.2.zip /ammc.zip
RUN unzip /ammc.zip -d /ammc \
    && rm /ammc.zip \
    && chmod +x /ammc/linux64/ammc-amb

ENV ARGS="-t -a -w 8123"

ENTRYPOINT ["tail", "-f", "/dev/null"]
# CMD ["/ammc/linux64/ammc-amb ", $ARGS]