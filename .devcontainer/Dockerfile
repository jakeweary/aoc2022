FROM alpine

# essentials
RUN apk add build-base
RUN apk add git curl jq
RUN apk add mandoc man-pages
RUN apk add bash bash-completion
RUN sed -i s/ash/bash/ /etc/passwd

# rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- \
  -y --default-toolchain nightly --profile minimal

# zig: compiler
RUN json=$(curl -fsSL https://ziglang.org/download/index.json) && \
  curl -fLO $(printf %s "$json" | jq -r '.master["'$(uname -m)'-linux"].tarball') && \
  tar -xf *.tar.xz && \
  rm *.tar.xz && \
  mv zig-linux-* /usr/local/bin/zig.d && \
  ln -sfn /usr/local/bin/zig.d/zig /usr/local/bin/zig

# zig: zls
RUN curl -fLO https://zig.pm/zls/downloads/$(uname -m)-linux/bin/zls && \
  chmod +x zls && \
  mv zls /usr/local/bin
