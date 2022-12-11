```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│          1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25  │  ○ - 1 part
│ BQN      ●  ●  -  -  ●  ●  -  ●  -  ●  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  │  ● - 2 parts
│ Haskell  -  -  ●  ●  ●  ●  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  │
│ Rust     ●  ●  ●  ●  -  -  ●  -  -  -  ●  -  -  -  -  -  -  -  -  -  -  -  -  -  -  │
│ Zig      ●  ●  ●  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  │
└─────────────────────────────────────────────────────────────────────────────────────┘
```
```sh
# resolve dependencies and etc.
make configure

# run in debug mode
make

# run in release mode
make RELEASE=1

# pick languages to run
make zig rust
```
