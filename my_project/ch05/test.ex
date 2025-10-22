defmodule Query do
  run_query =
    fn query_def ->
      Process.sleep(2000)
      "#{query_def} result"
    end

  async_query =
    fn query_def ->
      caller = self()
      spawn(fn ->
        query_result = run_query.(query_def)
        send(caller, {:query_result, query_result})
      end)
    end
end
