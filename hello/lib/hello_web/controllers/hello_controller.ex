defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> assign(:myVar, "Howdie Doo")
    |> render("index.html", message: "Hello")
  end

  def show(conn, %{"messenger" => messenger}) do
    render conn, "show.html", messenger: messenger
  end

  def map(conn, _params) do
    conn
    |> assign(:dict, %{apples: 5, oranges: 3, bananas: 6})
    |> render("map.html")
  end
end
