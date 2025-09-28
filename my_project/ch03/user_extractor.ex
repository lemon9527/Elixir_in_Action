defmodule UserExtractor do
  defp extract_login(%{"login" => login}), do: {:ok, login}
  defp extract_login(_), do: {:error, :no_login}

  defp extract_email(%{"email" => email}), do: {:ok, email}
  defp extract_email(_), do: {:error, :no_email}

  defp extract_password(%{"password" => password}), do: {:ok, password}
  defp extract_password(_), do: {:error, :no_password}


  # def extract_user(user) do
  #   case extract_login(user) do
  #     {:ok, login} ->
  #       case extract_email(user) do
  #         {:ok, email} ->
  #           case extract_password(user) do
  #             {:ok, password} ->
  #               {:ok, %{login: login, email: email, password: password}}
  #             {:error, reason} -> {:error, reason}
  #           end
  #         {:error, reason} -> {:error, reason}
  #       end
  #     {:error, reason} -> {:error, reason}
  #   end
  # end


  def extract_user(user) do
    with {:ok, login} <- extract_login(user),
         {:ok, email} <- extract_email(user),
         {:ok, password} <- extract_password(user) do
      {:ok, %{login: login, email: email, password: password}}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
