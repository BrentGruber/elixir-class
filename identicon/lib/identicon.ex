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
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
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

  @doc """
    Builds a pixel map given a 5x5 grid of booleans
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
    Draws an image in memory given a pixel map and color
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250,250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      # very uncommon case where object is being updated in place
      :egd.filledRectangle(image, start, stop, fill)
    end

    # render image in memory
    :egd.render(image)
  end

  @doc """
    Saves an Identicon image from memory to disk
  """
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end
end
