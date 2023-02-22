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
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

COPY ammc-v6.2.2.zip /ammc.zip
# RUN mkdir /ammc-amb
# RUN unzip /ammc.zip -d /ammc-amb
# Extract the ammc-amb binary from each platform-specific folder in the ZIP file
# RUN unzip -j /ammc.zip "mac-m1/ammc-amb" -d /ammc-amb/mac-m1
# RUN unzip -j /ammc.zip "mac-intel/ammc-amb" -d /ammc-amb/mac-intel
RUN unzip -j /ammc.zip "linux64/ammc-amb" -d /
# RUN unzip -j /ammc.zip "windows64/ammc-amb.exe" -d /ammc-amb/windows64
RUN rm /ammc.zip

# Copy the ammc-amb binaries from the builder stage
RUN mv /ammc-amb /usr/local/bin/

# Set permissions on the ammc-amb binary
# RUN chmod +x /usr/local/bin/ammc-amb/mac-m1/ammc-amb
# RUN chmod +x /usr/local/bin/ammc-amb/mac-intel/ammc-amb
RUN chmod +x /usr/local/bin/ammc-amb
# RUN chmod +x /usr/local/bin/ammc-amb/windows64/ammc-amb.exe

# Set up the appropriate ENTRYPOINT for each platform
# ENV ARGS="-t -a -w 8123"
# ENTRYPOINT ["tail", "-f", "/dev/null"]
## add entrypoint.sh into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
# CMD [ $ARGS ]