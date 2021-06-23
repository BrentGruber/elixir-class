defmodule Identicon do
  @moduledoc """
  Generate an identicon based on an input string
  """

  def main(input) do
    input
    |> hash_string
    |> pick_color
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
end
