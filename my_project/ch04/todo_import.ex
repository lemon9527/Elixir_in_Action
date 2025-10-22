defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      fn entry, todo_list_acc ->
        add_entry(todo_list_acc, entry)
      end
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)

    new_entries = Map.put(
      todo_list.entries,
      todo_list.next_id,
      entry
    )

    %TodoList{todo_list |
      entries: new_entries,
      next_id: todo_list.next_id + 1
    }
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    new_entries = Map.delete(
      todo_list.entries,
      entry_id
    )

    %TodoList{todo_list |
      entries: new_entries,
      next_id: todo_list.next_id - 1
    }
  end
end

defmodule TodoList.CsvImporter do
  def import(path) do
    File.stream!(path)
    |> Stream.map(fn line -> String.trim_trailing(line) end)
    # |> Enum.each(fn line -> IO.puts("#{line}") end)
    |> Stream.map(&String.split(&1, ","))
    # |> Stream.map(fn [date_str, title] -> [Date.from_iso8601!(date_str), title] end)
    |> Stream.map(fn [date_str, title] -> %{date: Date.from_iso8601!(date_str), title: title} end)
    |> Enum.to_list()
  end
end
