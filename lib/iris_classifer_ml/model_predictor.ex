defmodule IrisClassiferMl.ModelPredictor do
  @moduledoc false
  alias IrisClassiferMl.PythonHelper, as: Helper

  def predict(args) do
    call_python(:classifier, :predict_model, args)
  end

  defp call_python(module, func, args) do
    {:ok, pid} = Helper.py_instance()
    result = Helper.py_call(pid, module, func, args)

    pid
    |> Helper.py_stop()

    result
  end
end
