defmodule AdventOfCode2024.Utils do
  def read_from_file({:ok, file}) do
    IO.read(file, :eof)
  end

  def read_from_file({_, error}) do
    IO.puts("Error: #{:file.format_error(error)}")
  end
end
