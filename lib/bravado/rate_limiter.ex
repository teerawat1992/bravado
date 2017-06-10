defmodule Bravado.RateLimiter do
  use GenServer

  @max_per_minute Application.get_env(:bravado, :max_rate_limit_per_minute)
  @interval :timer.seconds(60)
  @table_name :rate_limiter_requests

  # client

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def log(ip) do
    case :ets.update_counter(@table_name, ip, {2, 1}, {ip, 0}) do
      count when count > @max_per_minute ->
        {:error, :rate_limited}

      count ->
        {:ok, count}
    end
  end

  def reset do
    :ets.delete_all_objects(@table_name)
  end

  # server

  def init(_) do
    :ets.new(@table_name, [:set, :named_table, :public, read_concurrency: true,
                                                        write_concurrency: true])
    schedule_sweep()
    {:ok, %{}}
  end

  def handle_info(:sweep, state) do
    reset()
    schedule_sweep()
    {:noreply, state}
  end

  defp schedule_sweep do
    Process.send_after(self(), :sweep, @interval)
  end
end
