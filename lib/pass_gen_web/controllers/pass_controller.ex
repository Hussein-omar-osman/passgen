defmodule PassGenWeb.PassController do
  use PassGenWeb, :controller

  def pass(conn, params) do
    # IO.puts("++++++++++++++++")
    # IO.inspect(conn)
    # IO.puts("++++++++++++++++")
    # IO.inspect(params)

    # conn
    # |> render("ack.json", params)
    new_params = check_params(params)
    IO.puts("++++++++++++++++")
    IO.inspect(params)
    IO.puts("++++++++++++++++")
    IO.inspect(new_params)
    case PasswordGenerator.generate(new_params) do
      {:ok, pass} -> json(conn, Map.merge(%{"password" => pass}, new_params))
      {:error, error} -> json(conn, %{error: error})
    end
    # PasswordGenerator.generate(params)
    # json(conn, %{password: "pass"})
  end

  defp check_params(params) do
    case params === %{} do
      true -> %{"length" => "15","numbers" => "true","symbols" => "true","uppercase" => "true"}
      false -> check_for_length(params)
    end
  end

  defp check_for_length(obj)  do
    case Map.has_key?(obj, "length") do
      true -> obj
      false -> Map.merge(%{"length" => "15"}, obj)
    end
  end

end
