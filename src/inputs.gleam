import simplifile

pub fn load_input_text(filename: String) -> String {
  let filepath = "./inputs/" <> filename
  let assert Ok(content) = simplifile.read(from: filepath)
  content
}
