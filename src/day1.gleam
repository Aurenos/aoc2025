import gleam/io
import inputs

pub fn run(part: String) {
  case part {
    "1" -> part1()
    _ -> io.println("Invalid part for day 1")
  }
}

pub fn part1() {
  let input_text = inputs.load_input_text("d1p1.txt")
  io.println(input_text)
}
