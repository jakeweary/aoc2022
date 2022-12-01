time := time -f "%E real, %U user, %S sys, %P cpu, %Mk mem"

ifdef RELEASE
rust_path := release
rust_flags := -q --release
zig_flags := -Drelease-fast -Dlibc -Dstrip
else
rust_path := debug
rust_flags := -q
endif

.PHONY: all rust zig
all: rust zig

rust:
	$(info --- $@ ---)
	@cd $@; cargo build $(rust_flags)
	@$(time) ./$@/target/$(rust_path)/aoc

zig:
	$(info --- $@ ---)
	@cd $@; zig build $(zig_flags)
	@$(time) ./$@/zig-out/bin/aoc
