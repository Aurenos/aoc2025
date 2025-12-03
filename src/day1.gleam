import gleam/int
import gleam/list
import gleam/string
import inputs

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

fn get_rotations() -> List(Rotation) {
  inputs.load_input_text("d1.txt")
  |> string.split(on: "\n")
  |> list.map(parse_rotation)
}

pub fn part1() {
  get_rotations()
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

pub fn part2() {
  get_rotations()
  |> list.fold(#(50, 0), fn(acc, rotation) {
    let #(current_dial, password) = acc
    let rotated = case rotation {
      Left(n) -> current_dial - n
      Right(n) -> current_dial + n
    }
    let assert Ok(new_dial) = int.modulo(rotated, 100)

    let start = case rotation {
      Left(_) -> current_dial - 1
      Right(_) -> current_dial + 1
    }

    let zeros =
      list.range(start, rotated)
      |> list.fold(0, fn(acc, n) {
        let assert Ok(dial_num) = int.modulo(n, 100)
        case dial_num {
          0 -> acc + 1
          _ -> acc
        }
      })

    #(new_dial, password + zeros)
  })
  |> echo

  Nil
}
