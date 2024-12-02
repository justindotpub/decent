# Decent

A simple Pretty Good Privacy (PGP) Elixir library, wrapping functions from the [pgp Rust crate](https://crates.io/crates/pgp). Enables encrypting with a public key and decrypting with the corresponding private key.

## Installation

The package can be installed by adding `decent` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:decent, "~> 0.1"}
  ]
end
```

## License

Copyright 2024 Justin Johnson

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
