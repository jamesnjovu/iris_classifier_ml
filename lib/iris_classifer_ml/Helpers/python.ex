defmodule IrisClassiferMl.PythonHelper do
  @moduledoc false

  def py_instance(version \\ 'python3') do
    path = [:code.priv_dir(:iris_classifer_ml), "helper/python"] |> Path.join()
    :python.start([{:python_path, to_charlist(path)}, {:python, version}])
  end

  def py_call(pid, module, function, args \\ []) do
    :python.call(pid, module, function, args)
  end

  def py_cast(pid, message) do
    :python.cast(pid, message)
  end

  def py_stop(pid) do
    :python.stop(pid)
  end

end
