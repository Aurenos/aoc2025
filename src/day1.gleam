import gleam/int
import gleam/io
import gleam/list
import gleam/string
import inputs

pub fn run(part: String) {
  case part {
    "1" -> part1()
    _ -> io.println("Invalid part for day 1")
  }
}

type Rotation {
  Left(Int)
  Right(Int)
}

fn parse_rotation(input: String) -> Rotation {
  case input {
    "L" <> n -> {
      let assert Ok(value) = int.parse(n)
      Left(value)
    }
    "R" <> n -> {
      let assert Ok(value) = int.parse(n)
      Right(value)
    }
    _ -> panic as "Invalid rotation"
  }
}

fn part1() {
  inputs.load_input_text("d1p1.txt")
  |> string.split(on: "\n")
  |> list.map(parse_rotation)
  |> list.fold(#(50, 0), fn(acc, rotation) {
    let #(current_dial, password) = acc
    let rotated = case rotation {
      Left(n) -> current_dial - n
      Right(n) -> current_dial + n
    }
    let assert Ok(new_dial) = int.modulo(rotated, 100)

    case new_dial {
      0 -> #(new_dial, password + 1)
      _ -> #(new_dial, password)
    }
  })
  |> echo

  Nil
}
