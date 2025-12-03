import argv
import day1
import day2
import gleam/dict
import gleam/io

pub fn main() -> Nil {
  let day_part_map =
    dict.from_list([
      #(["1", "1"], day1.part1),
      #(["1", "2"], day1.part2),
      #(["2", "1"], day2.part1),
      #(["2", "2"], day2.part1),
    ])
  let args = argv.load().arguments
  case dict.get(day_part_map, args) {
    Ok(run) -> run()
    _ -> io.println("Invalid day or part")
  }
}
