defmodule VmData do
  defstruct cursor: 0, remaining: [], memory: [], input: nil, output: nil

  def new(memory, input \\ nil) do
    %VmData{ cursor: 0, remaining: memory, memory: memory, input: input }
  end
end
