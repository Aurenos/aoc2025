import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import inputs

pub fn run(part: String) {
  case part {
    "1" -> part1()
    "2" -> part2()
    _ -> io.println("Invalid part for day 2")
  }
}

type IDRange {
  IDRange(start: Int, end: Int)
}

fn parse_id_range(input: String) -> IDRange {
  let assert [start_str, end_str] = string.split(input, on: "-")
  let assert Ok(start) = int.parse(start_str)
  let assert Ok(end) = int.parse(end_str)
  IDRange(start:, end:)
}

fn id_ranges() -> List(IDRange) {
  inputs.load_input_text("d2.txt")
  |> string.trim()
  |> string.split(on: ",")
  |> list.map(parse_id_range)
}

fn part1() {
  id_ranges()
  |> list.fold(0, fn(acc, id_range) {
    let n =
      list.range(id_range.start, id_range.end)
      |> list.filter(fn(num) {
        let digits = num |> int.to_string() |> string.to_graphemes()
        let assert Ok(half) = digits |> list.length() |> int.divide(2)
        case list.sized_chunk(digits, into: half) {
          [digits1, digits2] -> digits1 == digits2
          _ -> False
        }
      })
      |> int.sum
    acc + n
  })
  |> echo

  Nil
}

fn part2() {
  id_ranges()
  |> list.fold(0, fn(acc, id_range) {
    let n =
      list.range(id_range.start, id_range.end)
      |> list.filter(fn(num) {
        let num_str = int.to_string(num)
        let str_len = string.length(num_str)
        let chars = string.to_graphemes(num_str)

        // there's probably a less jank way to do this check, but whatever it works
        use <- bool.guard(
          bool.and(str_len > 1, chars |> list.unique() |> list.length() == 1),
          True,
        )
        use <- bool.guard(str_len <= 2, False)

        let assert Ok(half) = int.divide(str_len, 2)
        let repeats_exist =
          list.range(2, half)
          |> list.any(fn(chunk_len) {
            let chunks = list.sized_chunk(chars, into: chunk_len)
            chunks |> list.unique() |> list.length() == 1
          })
        use <- bool.guard(repeats_exist, True)

        False
      })
      |> int.sum

    acc + n
  })
  |> echo

  Nil
}
