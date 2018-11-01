defmodule Hedwig.Responders.GoogleImages do
  use Hedwig.Responder
  require Logger

  @moduledoc """
  Uses Google Custom Search Engine to fetch images requested by the user.
  """

  @usage """
  hedwig image|img me <query> - Responds with a random image of the specified search term
  """
  respond ~r/(?:image|img)(?: me)?( -)? (.+)/i, msg do
    imgs = search_images(msg.matches[2])
    send msg, Enum.random(imgs)["link"]
  end

  def search_images(query) do
    url = "https://www.googleapis.com/customsearch/v1"
    headers = []
    opts = [
      params: [
        q: query,
        searchType: "image",
        safe: "high",
        fields: "items(link)",
        key: cse_key(),
        cx: cse_id(),
      ]
    ]

    case HTTPoison.get(url, headers, opts) do
      {:ok, %{status_code: 200, body: body}} ->
        res = Poison.decode! body
        res["items"]
      {_, res} ->
        Logger.warn inspect(res)
        :error
    end
  end

  def cse_key, do: Config.get_env(:hedwig_google_images, :google_cse_key)
  def cse_id, do: Config.get_env(:hedwig_google_images, :google_cse_key)
end
