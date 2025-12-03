import gleam/int
import gleam/list
import gleam/string
import inputs

type BatteryPack {
  BatteryPack(List(Int))
}

fn parse_pack(pack: String) {
  pack
  |> string.to_graphemes()
  |> list.map(fn(battery) {
    let assert Ok(num) = int.parse(battery)
    num
  })
  |> BatteryPack
}

fn packs() -> List(BatteryPack) {
  inputs.load_input_text("d3.txt")
  |> string.split(on: "\n")
  |> list.map(parse_pack)
}

pub fn part1() {
  packs()
  |> list.fold(0, fn(total, pack) {
    let BatteryPack(lst) = pack
    let len = list.length(lst)
    // I originally solved this using index_fold on lst, but I had this silly idea
    let assert [rest, [last]] = list.sized_chunk(lst, into: len - 1)
    let joltage =
      rest
      |> list.fold(#(0, 0), fn(digits, battery) {
        case digits {
          #(n, _) if battery > n -> #(battery, 0)
          #(n, m) if battery > m -> #(n, battery)
          _ -> digits
        }
      })

    let joltage = case last > joltage.1 {
      True -> #(joltage.0, last)
      False -> joltage
    }

    total + { joltage.0 * 10 } + joltage.1
  })
  |> echo

  Nil
}

pub fn part2() {
  todo
}
