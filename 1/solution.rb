# Read the input
input = File.read(File.dirname(__FILE__) + "/input").rstrip.split(", ")

# Imagine a compass
orientations = %w{ N E S W }

# Wake up our navigator
navigator = Hash.new(0)

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

  navigator[ orientations[0] ] += instruction[1..-1].to_i
end

# Ask our navigator about a shortcut
puts navigator["E"] - navigator["W"] + navigator["N"] - navigator["S"]
