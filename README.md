# NebulexDecoratedKeys

After upgrading to Elixir 1.16.0, I've identified a bug impacting the cache when using the
decorated functions. You can specify the keys which allows you to identify different cache keys.
Since Elixir 1.16.0, it looks broken like if the keys were not used in the cache key because it
serves always the first value returned

## Code impacted

```elixir
@decorate cacheable(
            cache: NebulexDecoratedKeys.Cache,
            keys: [name],
            opts: [ttl: :timer.minutes(15)]
          )
def hello(name) do
  "Hello, #{name}!"
end
```

## How to reproduce

Select Elixir 1.15.7, clean your `_build` folder and run the tests:

```shell
rtx shell elixir@1.15.7
elixir --version
rm -r _build
mix test
```

Result:
```
Elixir 1.15.7 (compiled with Erlang/OTP 26)

===> Analyzing applications...
===> Compiling shards
src/shards.erl:1505:23: Warning: type variable 'Pos' is only used once (is unbound)
src/shards.erl:1505:28: Warning: type variable 'Value' is only used once (is unbound)

==> decorator
Compiling 2 files (.ex)
Generated decorator app
==> nebulex
Compiling 45 files (.ex)
Generated nebulex app
==> nebulex_decorated_keys
Compiling 3 files (.ex)
Generated nebulex_decorated_keys app
.
Finished in 0.00 seconds (0.00s async, 0.00s sync)
1 test, 0 failures

Randomized with seed 969243
```

As you can see the test is **green**.

Now, select Elixir 1.16.0, clean your `_build` folder and run the tests:

```shell
rtx shell elixir@1.16.0
elixir --version
rm -r _build
mix test
```

```
Elixir 1.16.0 (compiled with Erlang/OTP 26)

===> Analyzing applications...
===> Compiling shards
src/shards.erl:1505:23: Warning: type variable 'Pos' is only used once (is unbound)
src/shards.erl:1505:28: Warning: type variable 'Value' is only used once (is unbound)

==> decorator
Compiling 2 files (.ex)
Generated decorator app
==> nebulex
Compiling 45 files (.ex)
Generated nebulex app
==> nebulex_decorated_keys
Compiling 3 files (.ex)
Generated nebulex_decorated_keys app


  1) test greets the world (NebulexDecoratedKeysTest)
     test/nebulex_decorated_keys_test.exs:4
     Assertion with == failed
     code:  assert NebulexDecoratedKeys.hello("John") == "Hello, John!"
     left:  "Hello, Jane!"
     right: "Hello, John!"
     stacktrace:
       test/nebulex_decorated_keys_test.exs:6: (test)


Finished in 0.00 seconds (0.00s async, 0.00s sync)
1 test, 1 failure

Randomized with seed 535869
```

Now, the test is **failing**.


**Note:** `rtx` is an equivalent of `asdf`, you can run `asdf shell elixir 1.16.0` or `asdf shell elixir 1.15.7`.
