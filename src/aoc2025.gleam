import argv
import day1
import gleam/io

pub fn main() -> Nil {
  case argv.load().arguments {
    ["1", part] -> day1.run(part)
    _ -> io.println("Invalid input")
  }
}
