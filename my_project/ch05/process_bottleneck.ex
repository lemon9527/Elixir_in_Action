# Demonstration of a process bottleneck
defmodule Server do
  def start do
    spawn(fn -> loop() end)
  end

  def send_msg(server, message) do
    send(server, {self(), message})

    receive do
      {:response, respnose} -> respnose
    end
  end

  defp loop do
    receive do
      {caller, msg} ->
        Process.sleep(1000)
        send(caller, {:response, msg})
    end

    loop()
  end
end

# Modified infinite loop with print and delay
defmodule LoopDemo do
  def start_loop do
    spawn(fn ->
      Stream.repeatedly(fn ->
        IO.puts("hello lemon")
        Process.sleep(10000)
        :rand.uniform()
      end)
      |> Stream.run()
    end)
  end
end
