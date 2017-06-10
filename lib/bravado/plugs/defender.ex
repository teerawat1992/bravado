defmodule Bravado.Defender do
  import Plug.Conn
  alias Bravado.RateLimiter

  def init(_), do: :ok

  def call(%{remote_ip: ip} = conn, _) do
    case RateLimiter.log(ip) do
      {:ok, _} ->
        conn

      {:error, :rate_limited} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(429, Poison.encode!(%{status: "error"}))
        |> halt()
    end
  end
end
