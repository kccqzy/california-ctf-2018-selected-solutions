FROM ubuntu:xenial

# We don't have locales here. So use C.UTF-8
ENV LANG C.UTF-8

# Set up path
ENV PATH /root/.local/bin:$PATH

# Update and upgrade basic build tools
RUN apt-get update
RUN apt-get install -y build-essential zlib1g-dev libtinfo-dev curl libgmp10 netbase ca-certificates

# Install stack
RUN curl -sSL https://get.haskellstack.org/ | sh

# Copy and build!
RUN stack setup --resolver lts-10.5
COPY ./src/package.yaml ./src/stack.yaml /src/
RUN cd /src && stack build --only-dependencies
COPY ./src/Main.hs /src/
RUN cd /src && stack install

# Production image
FROM busybox:latest

# Copy system libraries and config files
COPY --from=0 /etc/nsswitch.conf /etc/protocols /etc/services /etc/ssl /etc/
COPY --from=0 /lib64/ld-linux-x86-64.so.2 /lib64/
COPY --from=0 /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libutil.so.1 /lib/x86_64-linux-gnu/librt.so.1 /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/libnss_files.so.2 /lib/x86_64-linux-gnu/libnss_dns.so.2 /lib/x86_64-linux-gnu/libresolv.so.2 /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/
COPY --from=0 /usr/lib/x86_64-linux-gnu/libgmp.so.10 /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/
COPY --from=0 /usr/lib/x86_64-linux-gnu/gconv/UTF-16.so /usr/lib/x86_64-linux-gnu/gconv/UTF-32.so /usr/lib/x86_64-linux-gnu/gconv/UTF-7.so /usr/lib/x86_64-linux-gnu/gconv/gconv-modules /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache /usr/lib/x86_64-linux-gnu/gconv/
COPY --from=0 /bin/dash /bin/sh

# Copy our app and assets
COPY --from=0 /root/.local/bin/saffy-rosy-ice-cream-app /
COPY ./src/flag.png ./src/generic-user.svg /

# Set command to run
CMD /saffy-rosy-ice-cream-app
