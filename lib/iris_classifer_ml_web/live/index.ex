defmodule IrisClassiferMlWeb.IndexLive do
  @moduledoc false
  use IrisClassiferMlWeb, :live_view

  def render(assigns) do
    ~H"""
      <h1>Iris Classifier</h1>
      <h2>Please input parameters: </h2>

      <.live_component
        module={IrisClassiferMlWeb.FormComponent}
        id={:new} />
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
