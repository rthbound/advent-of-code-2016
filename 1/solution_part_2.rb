# Read the input
input = File.read(File.dirname(__FILE__) + "/input").rstrip.split(", ")

# Declare starting position
position = [0,0]

# Imagine a compass
orientations = %w{ N E S W }

# Wake up our navigator
navigator          = Hash.new(0)
previous_positions = Array.new

# Teach navigator some orienteering
def hit_the_road(route, previous_positions)
  route.detect { |point| previous_positions.include?(point) }
end

def path(a,b)
  path = a.send(a < b ? :upto : :downto, b).to_a[1..-1]
end

# Translate instructions
instructions = input.map do |instruction|
  case instruction[0]
  when "L"
    orientations.rotate! -1
  when "R"
    orientations.rotate!
  else
    raise "flibbedy flook"
  end

  # Identify destination
  navigator[ orientations[0] ] += instruction[1..-1].to_i

  # Move toward destination
  exit_condition = case orientations[0]
  when "N"
    p     = path(position[-1], position[-1] + instruction[1..-1].to_i)
    z     = Array.new(p.length, position[0])
    route = z.zip(p)
    hit_the_road(route, previous_positions)
  when "E"
    p     = path(position[0], position[0] + instruction[1..-1].to_i)
    z     = Array.new(p.length, position[-1])
    route = p.zip(z)
    hit_the_road(route, previous_positions)
  when "S"
    p     = path(position[-1], position[-1] - instruction[1..-1].to_i)
    z     = Array.new(p.length, position[0])
    route = z.zip(p)
    hit_the_road(route, previous_positions)
  when "W"
    p     = path(position[0], position[0] - instruction[1..-1].to_i)
    z     = Array.new(p.length, position[-1])
    route = p.zip(z)
    hit_the_road(route, previous_positions)
  end

  if exit_condition
    position = exit_condition
    break
  else
    previous_positions = previous_positions | route
    position = [navigator["E"] - navigator["W"], navigator["N"] - navigator["S"]]
  end
end

puts position[0].abs + position[1].abs
