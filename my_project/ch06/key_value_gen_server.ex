defmodule KeyValueStore do
  use GenServer

  def start do
    GenServer.start(KeyValueStore, nil, name: __MODULE__)
  end

  # GenServer.cast/2 的返回值总是 :ok，表示消息已成功发送到服务器进程。
  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def init(_init_arg) do
    # :timer.send_interval(5000, :cleanup)
    {:ok, %{}}
  end

  def handle_info(:cleanup, state) do
    IO.puts "performing cleanup..."
    {:noreply, state}
  end
  # handle_cast/2 的返回值
  # 必须返回 {:noreply, new_state}
  # 其中 new_state 是更新后的状态
  # 不会回复客户端

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  # handle_call/3 的返回值
  # 必须返回 {:reply, reply, new_state}
  # reply 是要返回给客户端的值
  # new_state 是更新后的状态
  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end
end
