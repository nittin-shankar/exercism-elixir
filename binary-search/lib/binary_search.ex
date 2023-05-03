defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    numbers_list = Tuple.to_list(numbers)

    {middle_index, middle_number} = middle_number_and_index(numbers_list)

    # Algorithm index will be 0 at the start
    algorithm_index = 0

    search(numbers_list, middle_index, middle_number, key, algorithm_index)
  end

  defp search(_numbers_list, _middle_index, middle_number, key, algorithm_index) when key == middle_number do
    {:ok, algorithm_index}
  end

  defp search(numbers_list, middle_index, middle_number, key, algorithm_index) when key > middle_number do
    count_until_middle_index = middle_index + 1
    new_numbers_list = Enum.drop(numbers_list, count_until_middle_index)

    {middle_index, middle_number} = middle_number_and_index(new_numbers_list)

    search(numbers_list, middle_index, middle_number, key, algorithm_index + 1)
  end

  defp search(numbers_list, middle_index, middle_number, key, algorithm_index) when key < middle_number do
    count_until_middle_index = (middle_index + 1) |> Integer.to_string() |> String.replace_prefix("", "-") |> String.to_integer()
    new_numbers_list = Enum.drop(numbers_list, count_until_middle_index)

    {middle_index, middle_number} = middle_number_and_index(new_numbers_list)

    search(numbers_list, middle_index, middle_number, key, algorithm_index + 1)
  end

  defp middle_number_and_index(numbers_list) do
    middle_index = Enum.count(numbers_list) |> div(2)
    middle_number = Enum.at(numbers_list, middle_index)

    {middle_index, middle_number}
  end

end
