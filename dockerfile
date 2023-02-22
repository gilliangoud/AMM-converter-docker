# FROM ubuntu:latest

# RUN apt-get update && \
#     apt-get install -y curl unzip && \
#     rm -rf /var/lib/apt/lists/*

# WORKDIR /

# copy ammc-v6.2.2.zip /ammc.zip
# RUN unzip /ammc.zip -d /ammc \
#     && rm /ammc.zip \
#     && chmod +x /ammc/linux64/ammc-amb

# ENV ARGS="-t -a -w 8123"

# ENTRYPOINT ["tail", "-f", "/dev/null"]
# CMD ["/ammc/linux64/ammc-amb ", $ARGS]

#######
FROM ubuntu:latest as builder

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*
copy ammc-v6.2.2.zip /ammc.zip
WORKDIR /

# Extract the ammc-amb binary from each platform-specific folder in the ZIP file
RUN unzip -j -d /tmp /ammc.zip "mac-m1/ammc-amb" "mac-intel/ammc-amb" "linux64/ammc-amb" "windows64/ammc-amb"

FROM ubuntu:latest

# Copy the ammc-amb binaries from the builder stage
COPY --from=builder /tmp/ammc-amb /usr/local/bin/

# Set up the appropriate ENTRYPOINT for each platform
ENV ARGS="-t -a -w 8123"
ENTRYPOINT [ "/usr/local/bin/ammc-amb" ]
CMD [ $ARGS ]