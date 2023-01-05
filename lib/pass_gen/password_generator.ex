defmodule PasswordGenerator do
  @moduledoc """
  Generates random password depending on paramaters. Module main function is `generate(options)`.
  That functon takes the options map.
  Options example:
      options = %{
        "length" => "5",
        "numbers" => "false",
        "uppercase" => "false",
        "symbols" => "false"
      }
  The options are only 4, `length`, `numbers`, `uppercase`, `symbols`.
  """
  @symbols "!#$%&()*+,-./:;<=>?@[]^_{|}~"

  @doc """
  Generates password for given options.
  ## Examples
      options = %{
        "length" => "5",
        "numbers" => "false",
        "uppercase" => "false",
        "symbols" => "false"
      }
      iex> PasswordGenerator.generate(options)
      {:ok, "abcdf"}
      options = %{
        "length" => "5",
        "numbers" => "true",
        "uppercase" => "false",
        "symbols" => "false"
      }
      iex> PasswordGenerator.generate(options)
      {:ok, "ab1d3"}
  """
  @spec generate(options :: map()) :: {:ok, binary()} | {:error, binary()}
  def generate(options) do
    validate_length(options)
    |> validate_length_is_integer()
    |> validate_options_values_are_boolean()
    |> validate_options()
  end

  # Checks if the length options is included, returns the options or {:error, error}
  @spec validate_length(options :: map()) :: map() | {:error, binary()}
  defp validate_length(options) do
    case Map.has_key?(options, "length") do
      true ->
        options

      false ->
        {:error, "Please provide a length"}
    end
  end

  # Validates that the lenght value is a number, returns the options or {:error, error}
  @spec validate_length_is_integer(options :: map() | {:error, binary()}) ::
          {:error, binary()} | map()
  defp validate_length_is_integer({:error, error}), do: {:error, error}

  defp validate_length_is_integer(options) do
    numbers = Enum.map(0..9, &Integer.to_string(&1))
    length = options["length"]

    case String.contains?(length, numbers) do
      true ->
        options

      false ->
        {:error, "Please provide a length"}
    end
  end

  # Validates that the values of the options without the length
  # are booleans, returns the options or {:error, error}
  @spec validate_options_values_are_boolean(options :: map() | {:error, binary()}) ::
          map() | {:error, binary()}
  def validate_options_values_are_boolean({:error, error}), do: {:error, error}

  def validate_options_values_are_boolean(options) do
    options_without_length = Map.delete(options, "length")
    options_values = Map.values(options_without_length)
    # Iterate over the values and converts them to atoms and check if boolean
    # If not all the values are booleans false is returned, true otherwise.
    value =
      options_values
      |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean() end)

    case value do
      true ->
        options

      false ->
        {:error, "Only booleans allowed for options values"}
    end
  end

  # Validates that all options are valid, returns error when an invalid option is found.
  defp validate_options({:error, error}), do: {:error, error}

  defp validate_options(options) do
    length_to_integer = options["length"] |> String.trim() |> String.to_integer()
    options_without_length = Map.delete(options, "length")
    options = ["lowercase_letter" | included_options(options_without_length)]
    included = include(options)
    length = length_to_integer - length(included)
    random_strings = generate_strings(length, options)
    strings = included ++ random_strings
    invalid_option? = false in strings

    case invalid_option? do
      true ->
        {:error, "Only options allowed numbers, uppercase, symbols."}

      false ->
        string =
          strings
          |> Enum.shuffle()
          |> to_string()

        {:ok, string}
    end
  end

  @spec generate_strings(length :: integer(), options :: list()) :: list()
  defp generate_strings(length, options) do
    Enum.map(1..length, fn _ ->
      Enum.random(options) |> get()
    end)
  end

  @spec include(options :: list()) :: list()
  defp include(options) do
    options
    |> Enum.map(&get(&1))
  end

  # Letters can be represented by the binary value
  # example ?a = 97 and <<?a>> = "a"
  # Enum.random takes a range of integers
  # passing binary values you get all the letters of the alphabet
  # Returns a letter string for the given option, false when not a valid option
  @spec get(binary()) :: binary() | false
  defp get("lowercase_letter") do
    <<Enum.random(?a..?z)>>
  end

  defp get("numbers") do
    Enum.random(0..9)
    |> Integer.to_string()
  end

  defp get("uppercase") do
    <<Enum.random(?A..?Z)>>
  end

  defp get("symbols") do
    symbols =
      @symbols
      |> String.split("", trim: true)

    Enum.random(symbols)
  end

  defp get(_option), do: false

  # Returns a list of strings of included options
  @spec included_options(options :: map()) :: list()
  defp included_options(options) do
    # Returns a list of key value pairs when value is true
    # example [{"numbers", true}, {"uppercase", true}]
    # then keys get mapped and converted to atoms
    # example [:numbers, :uppercase]
    options
    |> Enum.filter(fn {_key, value} ->
      value |> String.trim() |> String.to_existing_atom()
    end)
    |> Enum.map(fn {key, _value} -> key end)
  end
end
