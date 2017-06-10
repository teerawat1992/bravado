defmodule Bravado.RateLimiterTest do
  use ExUnit.Case

  alias Bravado.RateLimiter

  setup do
    {:ok, ip: "10.169.182.16"}
  end

  test "log rate limit for given ip", %{ip: ip} do
    for num <- 1..5 do
      assert RateLimiter.log(ip) == {:ok, num}
    end

    # after 5 times

    assert RateLimiter.log(ip) == {:error, :rate_limited}

    # reset

    RateLimiter.reset()

    assert RateLimiter.log(ip) == {:ok, 1}
  end
end
