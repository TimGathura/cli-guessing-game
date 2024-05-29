defmodule G do
  @moduledoc """
  Alias for the main module
  """
  alias GuessingGame, as: G
  def g(), do: G.generate()
  def start?(), do: G.start?()
  def start(), do: G.start()
  def rand(), do: G.random_number()
end

defmodule GuessingGame do
  @moduledoc """
  Main module for the game
  """

  # - - - Start the game - - -
  def start?() do
    IO.puts("Welcome to the guessing game!")
    IO.puts("Enter 'y' to continue or 'n' to exit")

    case IO.gets("") do
      "y\n" -> next()
      "n\n" -> terminate(2)
      _ -> terminate(2)
    end
  end

  # Helps start?/0 start the game
  defp next() do
    IO.puts("_ _ _ _ _ _ _ _ _ _ _ _ _ _ _")
    IO.puts("\nGreat! The rules are simple.")
    IO.puts("Guess the lucky number in a range of 10 values")
    IO.puts("You have 3 chances")
    IO.puts("Good luck!")
    IO.puts("\nEnter 's' to start the game.")

    case IO.gets("") do
      "s\n" -> start()
      _ -> terminate(1)
    end
  end

  # HELPER: Prints the loading dot
  defp print_loading_dot() do
    IO.write(".")
    :timer.sleep(500)
  end

  # - - - Starts the actual game - - -
  def start() do
    IO.write("Initialising game")
    1..3
    |> Enum.each(fn _ -> print_loading_dot() end)

    generate()
  end

  # - - - Main functionality - - -
  def generate() do
    IO.puts("\nThe Game has started!")

    IO.write("Generating lucky number")
    1..3
    |> Enum.each(fn _ -> print_loading_dot() end)

    # Remove 0 from range
    seed =
      case random_gen() do
        0 -> 1
        value -> value
      end

    IO.puts("\nLucky Number has been generated.")

    guess(seed, 0)
  end

  def guess(seed, attempts) when attempts < 3 do
    IO.puts("Seed is #{seed}")

    input = get_user_input(attempts + 1)
    parsed_input = parse_input(input)

    handle_guess(seed, parsed_input, attempts)
  end

  def guess(seed, 3) do
    IO.puts("All attempts used. Better luck next time!")
    IO.puts("Lucky number was #{seed}")

    play_again?()
  end

  defp get_user_input(attempt_count) do
    String.trim(IO.gets("Enter your guess (attempt: #{attempt_count}/3): "))
  end

  defp parse_input(input) do
    case Integer.parse(input) do
      :error -> :error
      {num, ""} -> num
      _ -> :error
    end
  end

  defp handle_guess(seed, :error, attempts) do
    IO.puts("Invalid input: Must be an integer(1-10)")
    guess(seed, attempts)
  end

  defp handle_guess(seed, parsed_input, attempts) when parsed_input < 1 or parsed_input > 10 do
    IO.puts("Invalid range: Must be (1-10)")
    guess(seed, attempts + 1)
  end

  defp handle_guess(seed, parsed_input, attempts) when parsed_input == seed do
    IO.puts("Congratulations! You guessed the lucky number #{seed} in #{attempts + 1} attempts.")
    play_again?()
  end

  defp handle_guess(seed, parsed_input, attempts)
       when parsed_input == seed + 1 or parsed_input == seed - 1 do
    IO.puts("So Close")
    guess(seed, attempts + 1)
  end

  defp handle_guess(seed, parsed_input, attempts)
       when parsed_input == seed + 2 or parsed_input == seed - 2 do
    IO.puts("Almost there")
    guess(seed, attempts + 1)
  end

  defp handle_guess(seed, parsed_input, attempts) when parsed_input > seed do
    IO.puts("Too High")
    guess(seed, attempts + 1)
  end

  defp handle_guess(seed, parsed_input, attempts) when parsed_input < seed do
    IO.puts("Too Low")
    guess(seed, attempts + 1)
  end

  # Generates random number in range of 1 and 10
  defp random_gen() do
    seed = :rand.uniform()
    seed
    |> rounding()
    |> multiply()
    |> trunc()
  end

  # Aliasing for random_gen/0 in G Module
  def random_number() do
    random_gen()
  end

  # HELPER: Rounds a number to 1dp
  defp rounding(float) do
    Float.round(float, 1)
  end

  # HELPER: Multiply a number by 10
  defp multiply(num) do
    num * 10
  end

  defp play_again?() do
    IO.puts("Want to play again? (y/n)")

    case IO.gets("") |> String.trim() |> String.downcase() do
      "y" -> start()
      "n" -> terminate(1)
      _ -> terminate(1)
    end
  end

  # - - - Terminates the game - - -
  def terminate(num) do
    if num == 1 do
      IO.puts("Later Champ!")
    else
      IO.puts("Something else")
    end
    # After calling terminate/0, return from the function to prevent further execution
    :ok
  end
end

G.start?()
