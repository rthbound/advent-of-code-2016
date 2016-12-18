# Read the input
require 'benchmark'
input  = File.read(File.dirname(__FILE__) + "/input").rstrip

class SushiStackError < SystemStackError
end
class SushiChef
  def initialize(input, output = 0)
    @input  = input
    @output = output
    @stack  = 0
  end

  def hajime
    @stack += 1
    raise SushiStackError if @stack > 2777
    snack

    directions = @input[/\d+x\d+/]

    if directions
      entries, n = *directions.split("x").map(&:to_i)

      @input.slice! 0..(directions.length + 1)

      @input.prepend(@input[0..entries - 1] * (n-1))

      puts "Fetch more soy sauce. #{ @output } down, #{ @input.length } to go. #{ @input.count("(") } instructions await."
      hajime()
    end
  rescue SushiStackError
  end

  def input
    @input
  end

  def output
    @output
  end

  private

    def snack
      @input.index("(").tap do |o|
        case o
        when 0
        when nil
          @output += @input.length
          @input = ""
        else
          @output += o
          @input.slice! 0..(o-1)
        end
      end
    end
end

def run_solution(puzzle)
  s = SushiChef.new(puzzle)
  loop do
    s.hajime

    break if s.input.empty?

    s = SushiChef.new(s.input, s.output)
  end

  puts "☃ Thank you, have a nice day ☃"
  puts s.output
  puts "☃ Thank you, have a nice day ☃"
end


%w{
  (3x3)XYZ
  X(8x2)(3x3)ABCY
  (27x12)(20x12)(13x14)(7x10)(1x12)A
  (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN
}.each {|s| run_solution(s) }

puts "#" * 80
puts "#" * 80
puts "#" * 80
puts "#" * 80

run_solution(input)
