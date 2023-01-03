defmodule PassGenWeb.PassController do
  use PassGenWeb, :controller

  def pass(conn, params) do
    IO.puts("++++++++++++++++")
    IO.inspect(conn)
    IO.puts("++++++++++++++++")
    IO.inspect(params)

    conn
    |> render("ack.json", %{success: true, message: "ping"})
  end
end
