defmodule IrisClassiferMlWeb.FormComponent do
  @moduledoc false
  use IrisClassiferMlWeb, :live_component
  alias IrisClassiferMl.IrisParams, as: Iris
  alias IrisClassiferMl.ModelPredictor, as: ML

  def render(assigns) do
    ~H"""
      <div><p class="alert alert-info" role="alert"
    phx-click="lv:clear-flash"
    phx-value-key="info"><%= live_flash(@flash, :info) %></p>
        <form phx-submit="save" phx-target={@myself}>
          <label>Sepal Length (cm)</label>
          <input type="number" step="any" name="sepal_length" required/>

          <label>Sepal Width (cm)</label>
          <input type="number" step="any" name="sepal_width" required/>

          <label>Petal Length (cm)</label>
          <input type="number" step="any" name="petal_length" required/>

          <label>Petal Width (cm)</label>
          <input type="number" step="any" name="petal_width" required/>

          <div>
            <%= submit "Predict" %>
          </div>
        </form>
      </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
    }
  end

  @impl true
  def handle_event(
        "save",
        %{
          "sepal_length" => sepal_length,
          "sepal_width" => sepal_width,
          "petal_length" => petal_length,
          "petal_width" => petal_width
        },
        socket
      ) do
    with {sepal_length, _} <- Float.parse(sepal_length),
         {sepal_width, _} <- Float.parse(sepal_width),
         {petal_length, _} <- Float.parse(petal_length),
         {petal_width, _} <- Float.parse(petal_width) do
      iris_params = %Iris{
        sepal_length: sepal_length,
        sepal_width: sepal_width,
        petal_length: petal_length,
        petal_width: petal_width
      }

      class = ML.predict([Iris.encode(iris_params)])

      {:noreply, put_flash(socket, :info, "Predicted class: " <> to_string(class))}
    else
      _error ->
        {:noreply, put_flash(socket, :error, "Invalid parameters!")}
    end
  end
end
