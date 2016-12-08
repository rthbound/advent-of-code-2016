lines = File.readlines(File.dirname(__FILE__) + "/input").map(&:rstrip)
start = Complex(0, 0)

dpad = {
                 "U" => (0+1i),
  "L" => (-1+0i),              "R" => ( 1+0i),
                 "D" => (0-1i),
}

pad = {
  (-1 + 1i) => 1,
  ( 0 + 1i) => 2,
  ( 1 + 1i) => 3,
  (-1 + 0i) => 4,
  ( 0 + 0i) => 5,
  ( 1 + 0i) => 6,
  (-1 - 1i) => 7,
  ( 0 - 1i) => 8,
  ( 1 - 1i) => 9
}

raise "it's complicated" unless pad[start] == 5

lines.each do |line|
  digit = start
  line.split(//).each do |command|
    digit = Complex(
      (dpad[command] + digit).real.clamp(-1, 1),
      (dpad[command] + digit).imag.clamp(-1, 1))
  end

  $stdout.print pad[digit]
  $stdout.flush
end

puts nil
