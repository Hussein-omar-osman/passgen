# PassGen

Passgen is a simple password generator API built using the Phoenix framework. It has a single public endpoint that returns a randomly generated password.
Live demo: https://passgenn.fly.dev/

## Prerequisites

The prerequisites to run this project will depend on the mode you choose:

#### 1. From build

Before you can run this project, you will need to have the following:

1. `postgres` - our database you may find instructions on how to set it up [here](https://www.postgresql.org/)
2. `asdf` - the flexible runtime version manager, find it [here](https://asdf-vm.com/). This will ensure that everyone runs the same version of erlang and elixir.
3. `git` - package manager

To start the Rando server:

- Asdf requires you add a couple of plugins, which can easily be added using
  - `asdf plugin add erlang`
  - `asdf plugin add elixir`
- clone the repo
  - `git clone git@github.com:kirega/rando.git`
- Change in the directory
  - `cd rando`
- Run asdf to setup the environment
  - `asdf install`
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
- For testing, run `MIX_ENV=test mix test`

After testing the service, you can always reset the database to start all over again with `mix ecto.reset`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Endpoint

One public endpoint as root `/`

`GET` [`localhost:4000`](http://localhost:4000)

Returns a randomly generated password.

#### Parameters

- `length`: Optional. The length of the password to generate. Default is 15 characters.
- `uppercase`: Optional. Takes a boolean for uppercase to be included. Default is true.
- `numbers`: Optional. Takes a boolean for numbers to be included. Default is true.
- `symbols`: Optional. Takes a boolean for symbols to be included. Default is true.

#### Response

Examples:

Default:

```elixir
https://localhost:4000/
{
  "length": "15",
  "numbers": "true",
  "password": "7{FC7VF6a1Is6.2",
  "symbols": "true",
  "uppercase": "true"
}
```

Length:

```elixir
https://localhost:4000/?length=55
{
  "length": "55",
  "password": "ibdczzvjkvtqctprubepesymjnmtzzyamulaqtipezxpenhabvrhbuq"
}
```

With numbers and symbols:

```elixir
https://localhost:4000/?length=55&numbers=true&symbols=true
{
  "length": "55",
  "numbers": "true",
  "password": "va5s54[8z|8dh804=dp3&m5131+!e6(#7st8x1/^0uh;3+kjgs8_t26",
  "symbols": "true"
}
```

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
