
# Compiled using Elchemy v0.4.10
defmodule Hello do
  use Elchemy

  @doc """
  Does what Hajto wants
  
 
  """
  @doc """
  Prints "world!"
  
  
      iex> import Hello
      iex> return.([1, 2, 3, 4]).([1, 1, 2, 3, 3, 3, 4])
      [1, 3]
  
  
 
  """
  @spec return(list(integer), list(integer)) :: list(integer)
  curry return/2
  def return(a, b) do
    is_in_list = fn(list) -> fn(a) -> list
    |> (XList.foldl.(fn({num, is_prime}) -> fn(acc) -> if ( num == a ) do is_prime else acc end end end).(:false)).() end end
    primes = find_prime_occurences.(b)
    XList.filter.(is_in_list.(primes)).(a)
  end

  @spec find_prime_occurences(list(integer)) :: list({integer, boolean})
  curry find_prime_occurences/1
  def find_prime_occurences(list) do
    count_each = fn(current) -> fn({prev, found, acc}) -> if ( prev == current ) do {current, ( found + 1 ), acc} else {current, 1, [{prev, found} | acc]} end end end
    list
    |> (XList.sort).()
    |> (XList.foldl.(count_each).({-1, 0, []})).()
    |> (fn({_, _, acc}) -> acc
    |> (XList.map.(XTuple.map_second.(is_prime_naive))).() end).()
  end

  @doc """
  Prints "world!"
  
  
      iex> import Hello
      iex> is_prime_naive.(1)
      :false
  
      iex> import Hello
      iex> is_prime_naive.(2)
      :true
  
      iex> import Hello
      iex> is_prime_naive.(5)
      :true
  
      iex> import Hello
      iex> is_prime_naive.(10)
      :false
  
  
 
  """
  @spec is_prime_naive(integer) :: boolean
  curry is_prime_naive/1
  def is_prime_naive(a) do
    is_prime_naive_.(a).(a).(0)
  end

  @spec is_prime_naive_(integer, integer, integer) :: boolean
  curry is_prime_naive_/3
  def is_prime_naive_(a, b, acc) do
    cond do
      ( b == 0 ) -> ( acc == 2 )
      ( rem(a, b) == 0 ) -> is_prime_naive_.(a).(( b - 1 )).(( acc + 1 ))
      true -> is_prime_naive_.(a).(( b - 1 )).(acc)
    end
  end

end
