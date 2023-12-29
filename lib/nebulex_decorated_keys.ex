defmodule NebulexDecoratedKeys do
  @moduledoc """
  Documentation for `NebulexDecoratedKeys`.
  """

  use Nebulex.Caching

  @doc """
  Hello world.

  ## Examples

      iex> NebulexDecoratedKeys.hello()
      :world

  """
  @decorate cacheable(
              cache: NebulexDecoratedKeys.Cache,
              keys: [name],
              opts: [ttl: :timer.minutes(15)]
            )
  def hello(name) do
    "Hello, #{name}!"
  end
end
