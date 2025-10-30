defmodule ServerProcess do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()  # Invokes the callback to initialize the state
      loop(callback_module, initial_state)
    end)
  end

  defp loop(callback_module, current_state) do
    receive do
      {:call, request, caller} -> # Handles a call request
        {response, new_state} =
          callback_module.handle_call(  # Invokes the callback to handle the message
            request,
            current_state
          )

        send(caller, {:response, response})
        loop(callback_module, new_state)

      {:cast, request} ->
        new_state =
          callback_module.handle_cast(
            request,
            current_state
          )
        loop(callback_module, new_state)
    end
  end

  def call(server_id, request) do
    send(server_id, {:call, request, self()})  # Tags the request message as a call

    receive do
      {:response, response} ->  # Waits for response
        response                # Returns the response
    end
  end

  def cast(server_id, request) do
    send(server_id, {:cast, request}) # Issues a cast message
  end
end

defmodule KeyValueStore do
  def start do                          # interface function(接口函数)
    ServerProcess.start(KeyValueStore)
  end

  def put(pid, key, value) do
    ServerProcess.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end

  def init do                         # callback funtion(回调函数)
    %{}
  end

  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end
end
