time := time -f "%E real, %U user, %S sys, %P cpu, %Mk mem"

ifdef RELEASE
haskell_flags := -v0 -O2
haskell_path := opt/build
rust_flags := -q --release
rust_path := release
zig_flags := -Drelease-fast -Dlibc -Dstrip
else
haskell_flags := -v0
haskell_path := build
rust_flags := -q
rust_path := debug
endif

.PHONY: bqn haskell python rust zig all configure
all: bqn haskell python rust zig

configure:
	@cd haskell; cabal update

# ---

bqn:
	$(info --- $@ ---)
	@$(time) cbqn $@/main.bqn

haskell:
	$(info --- $@ ---)
	@cd $@; cabal build $(haskell_flags)
	@$(time) $@/dist-newstyle/build/*/*/*/x/aoc/$(haskell_path)/aoc/aoc

rust:
	$(info --- $@ ---)
	@cd $@; cargo build $(rust_flags)
	@$(time) $@/target/$(rust_path)/aoc

zig:
	$(info --- $@ ---)
	@cd $@; zig build $(zig_flags)
	@$(time) $@/zig-out/bin/aoc
