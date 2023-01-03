defmodule PassGenWeb.PassView do
  use PassGenWeb, :view

  def render("ack.json", %{success: success, message: message}) do
    %{success: success, message: message}
  end
end
