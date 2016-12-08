lines = File.readlines(File.dirname(__FILE__) + "/input").map(&:rstrip)

n_possible = 0
lines.each do |line|
  lengths = line.split("\s").map(&:to_i)

  n_possible += 1 if lengths[0]            +            lengths[1] > lengths[2]        &&
                     lengths.rotate[0]     +     lengths.rotate[1] > lengths.rotate[2] &&
                     lengths.rotate(-1)[0] + lengths.rotate(-1)[1] > lengths.rotate(-1)[2]
end

puts n_possible
