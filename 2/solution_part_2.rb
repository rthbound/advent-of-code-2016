lines = File.readlines(File.dirname(__FILE__) + "/input").map(&:rstrip)
start = Complex(0, 0)

dpad = {
                 "U" => (0+1i),
  "L" => (-1+0i),              "R" => ( 1+0i),
                 "D" => (0-1i),
}

pad = {
                                   ( 0 + 2i) => 1,
                  (-1 + 1i) => 2,  ( 0 + 1i) => 3,  ( 1 + 1i) => 4,
  (-2 + 0i) => 5, (-1 + 0i) => 6,  ( 0 + 0i) => 7,  ( 1 + 0i) => 8, ( 2 + 0i) => 9,
                  (-1 - 1i) => :A, ( 0 - 1i) => :B, ( 1 - 1i) => :C,
                                   ( 0 - 2i) => 9
}

raise "it's complicated" unless pad[start] == 7

lines.each do |line|
  digit = start
  line.split(//).each do |command|
    if pad.has_key?(dpad[command] + digit)
      digit += dpad[command]
    end
  end

  $stdout.print pad[digit]
  $stdout.flush
end

puts nil
