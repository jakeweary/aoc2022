FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y build-essential
RUN apt install -y curl git jq time

# python
RUN apt install -y python3

# haskell
RUN curl -sSf https://get-ghcup.haskell.org | \
  BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
  BOOTSTRAP_HASKELL_MINIMAL=1 \
  BOOTSTRAP_HASKELL_ADJUST_BASHRC=1 \
  bash
RUN ~/.ghcup/bin/ghcup install ghc 9.2.4 --set
RUN ~/.ghcup/bin/ghcup install hls 1.8.0.0 --set
RUN ~/.ghcup/bin/ghcup install cabal 3.6.2.0 --set
RUN apt install -y libgmp-dev

# rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
RUN ~/.cargo/bin/rustup toolchain install nightly --profile minimal

# zig: zls
RUN curl -fLO https://zig.pm/zls/downloads/$(uname -m)-linux/bin/zls && \
  chmod +x zls && mv zls /usr/local/bin

# zig: compiler
RUN json=$(curl -fsSL https://ziglang.org/download/index.json) && \
  curl -fLO $(printf %s "$json" | jq -r '.master["'$(uname -m)'-linux"].tarball') && \
  tar -xf *.tar.xz && rm *.tar.xz && \
  mv zig-linux-* /usr/local/bin/zig.d && \
  ln -sfn zig.d/zig /usr/local/bin/zig

# bqn
RUN git clone --depth 1 https://github.com/dzaima/CBQN.git && \
  cd CBQN && \
  make o3n-singeli CC=cc FFI=0 REPLXX=1 && \
  mv BQN /usr/local/bin/cbqn && \
  ln -sfn cbqn /usr/local/bin/bqn && \
  cd .. && rm -rf bqn

# ngn/k
RUN git clone --depth 1 https://codeberg.org/ngn/k.git && \
  cd k && \
  make k CC=cc && \
  mv k /usr/local/bin && \
  cd .. && rm -rf k

# futhark
RUN curl -fLO https://futhark-lang.org/releases/futhark-nightly-linux-x86_64.tar.xz && \
  tar -xf *.tar.xz && rm *.tar.xz && \
  mv futhark-*/bin/futhark /usr/local/bin && \
  rm -rf futhark-*
