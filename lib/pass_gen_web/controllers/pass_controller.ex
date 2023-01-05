defmodule PassGenWeb.PassController do
  use PassGenWeb, :controller

  def pass(conn, params) do
    # IO.puts("++++++++++++++++")
    # IO.inspect(conn)
    # IO.puts("++++++++++++++++")
    # IO.inspect(params)

    # conn
    # |> render("ack.json", params)
    # params = %{"length" => "20"}
    case PasswordGenerator.generate(params) do
      {:ok, pass} -> json(conn, Map.merge(%{"password" => pass}, params))
      {:error, error} -> json(conn, %{error: error})
    end
    # PasswordGenerator.generate(params)
    json(conn, %{password: "pass"})
  end

end
