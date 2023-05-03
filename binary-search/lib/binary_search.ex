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
    middle_values = middle_index_and_number(numbers_list)

    binary_search(
      numbers_list,
      key,
      middle_values
    )
  end

  def binary_search([], _key, _middle_values) do
    :not_found
  end

  def binary_search(numbers_list, key, {middle_index, middle_number}) when middle_number > key do
    new_numbers_list = remove_right_side_of_list(numbers_list)

    old_middle_index = middle_index

    {middle_index, middle_number} = middle_index_and_number(new_numbers_list)

    new_middle_index =
      if is_list_even(new_numbers_list) do
        (old_middle_index - middle_index)
      else
        (old_middle_index - middle_index) - 1
      end

    new_middle_values = {new_middle_index, middle_number}

    binary_search(new_numbers_list, key, new_middle_values)
  end

  def binary_search(numbers_list, key, {middle_index, middle_number}) when middle_number < key do
    new_numbers_list = remove_left_side_of_list(numbers_list)
    old_middle_index = middle_index

    {middle_index, middle_number} = middle_index_and_number(new_numbers_list)
    new_middle_index = old_middle_index + (middle_index + 1)

    new_middle_values = {new_middle_index, middle_number}

    binary_search(new_numbers_list, key, new_middle_values)
  end

  def binary_search(_numbers_list, key, {middle_index, middle_number}) when middle_number == key do
    {:ok, middle_index}
  end


  def remove_left_side_of_list(numbers_list) do
    {middle_index, _middle_number} = middle_index_and_number(numbers_list)
    start_count = middle_index + 1
    end_count = Enum.count(numbers_list)

    Enum.slice(numbers_list, start_count..end_count)
  end

  def remove_right_side_of_list(numbers_list) do
    {middle_index, _middle_number} = middle_index_and_number(numbers_list)

    Enum.slice(numbers_list, 0, middle_index)
  end

  def middle_index_and_number(numbers_list) do
    middle_index = Enum.count(numbers_list) |> div(2)
    middle_number = Enum.at(numbers_list, middle_index)

    {middle_index, middle_number}
  end

  def is_list_even(numbers_list) do
    0 == length(numbers_list) |> rem(2)
  end
end
