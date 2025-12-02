import argv
import day1
import day2
import gleam/io

pub fn main() -> Nil {
  case argv.load().arguments {
    ["1", part] -> day1.run(part)
    ["2", part] -> day2.run(part)
    _ -> io.println("Invalid input")
  }
}
