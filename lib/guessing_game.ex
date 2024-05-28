# < < < GUESSING GAME! > > >
# 1. App starts and asks for input from user
# 2. User has three chances to make a guess of a number in a arbitrary 10 digit range
# 3. Range is randomly generated between 1..100
# 4. Clues will be given to the user after each guess
# 5. Appropriate exception handling and control flow

# defmodule A do
#   alias Tokenizer, as: A
#   def a(expression), do: A.tokenize(expression)
# end

defmodule G do
@moduledoc """
Alias for the main module
"""
  alias GuessingGame, as: G
  def g(), do: G.guess()
  def start?(), do: G.start?()
  def start(), do: G.start()
  def rand(), do: G.random_number()
end


defmodule GuessingGame do
@moduledoc """
Main module for the game
"""

  def start?() do
    IO.puts("Welcome to the guessing game!")
    IO.puts("Enter 'y' to continue or 'n' to exit")

    case IO.gets("") do
      "y\n" -> next()
      "n\n" -> terminate()
      _ -> terminate()
    end
  end

  defp next() do
    1..15
    |> Enum.each(fn _ -> print_dash() end)
    IO.puts("\nGreat! The rules are simple.")
    IO.puts("Guess the lucky number in a range of 10 values")
    IO.puts("You have 3 chances")
    IO.puts("Good luck!")
    IO.puts("\nEnter 's' to start the game.")

    case IO.gets("") do
      "s\n" -> start()
      _ -> terminate()
    end
  end

  defp print_dash() do
    IO.write("_ ")
    :timer.sleep(50)
  end

  def start() do
    IO.write("Initialising game")
    1..3
    |> Enum.each(fn _ -> print_loading_dot() end)

    guess()
  end

  defp print_loading_dot() do
    IO.write(".")
    :timer.sleep(500)
  end

  def guess() do
    IO.puts("\nThe Game has started!")

    seed = random_gen()
    IO.puts("Guess the lucky number between #{seed} and #{seed}")

    # first = first value in the range
    # last = last value in the range
  end

  defp random_gen() do
    seed = :rand.uniform()
    seed
    |> rounding()
    |> multiply()
    |> trunc()
  end

  def random_number() do
    random_gen()
  end

  defp rounding(float) do
    Float.round(float, 1)
  end

  defp multiply(num) do
    num * 10
  end




  def terminate() do
    IO.puts("Later Champ!")
  end




end
