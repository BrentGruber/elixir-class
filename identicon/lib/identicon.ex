defmodule Identicon do
  @moduledoc """
  Generate an identicon based on an input string
  """

  def main(input) do
    input
    |> hash_string
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  @doc """
    generates an Image struct containing an MD5 hash list of hexadecimal numbers from a string `input`

  """
  def hash_string(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
    Creates an RGB color from the first 3 values of an image hex list
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row
  
    # [145, 46, 200, 46, 145]
    row ++ [second, first]
  end

  @doc """
    Generates a 5x5 grid from an image containing a hex list
  """
  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    grid = 
      hex_list
      |> Enum.chunk_every(3, 1)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Removes all odd members of an Image's grid
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index} = _square) ->  
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end
end
