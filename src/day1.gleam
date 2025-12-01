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
    let #(current, password) = acc
    let adjusted = case rotation {
      Left(n) -> current - n
      Right(n) -> current + n
    }
    let assert Ok(rotated) = int.modulo(adjusted, 100)

    case rotated {
      0 -> #(rotated, password + 1)
      _ -> #(rotated, password)
    }
  })
  |> echo

  Nil
}
