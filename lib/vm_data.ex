defmodule VmData do
  defstruct cursor: 0, remaining: [], memory: []

  def new(memory) do
    %VmData{ cursor: 0, remaining: memory, memory: memory }
  end
end
