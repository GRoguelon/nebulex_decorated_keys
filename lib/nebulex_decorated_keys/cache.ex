defmodule NebulexDecoratedKeys.Cache do
  use Nebulex.Cache,
    otp_app: :nebulex_decorated_keys,
    adapter: Nebulex.Adapters.Local
end
