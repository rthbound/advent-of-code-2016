lines = File.readlines(File.dirname(__FILE__) + "/input").map {|line| line.rstrip.split("\s").map(&:to_i) }.transpose.flatten.each_slice(3).to_a

n_possible = 0
lines.each do |line|
  n_possible += 1 if line[0]            +            line[1] > line[2]        &&
                     line.rotate[0]     +     line.rotate[1] > line.rotate[2] &&
                     line.rotate(-1)[0] + line.rotate(-1)[1] > line.rotate(-1)[2]
end

puts n_possible
