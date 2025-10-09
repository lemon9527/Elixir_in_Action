# Reporting the missing fields
defmodule UserExtraction do
  def extract_user(user) do
    case Enum.filter(
      ["login", "email", "password"], #注意，此处为string键
      &(not Map.has_key?(user, &1))
    ) do
      [] -> {:ok, user}
      missing_fields -> {:error, "Missing fields: #{Enum.join(missing_fields, ", ")}"}
    end
  end
end
# Example usage:
# user1 = %{"login" => "alice", "email" => "alice@example.com", "password" => "123456"}
# user2 = %{"login" => "bob", "email" => "bob@example.com"}
