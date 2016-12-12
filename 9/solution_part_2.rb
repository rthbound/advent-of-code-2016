# Read the input
require 'benchmark'
input  = File.read(File.dirname(__FILE__) + "/input").rstrip

class SushiChef
  def initialize(input, output = 0)
    @input = input
    @output = output
    @stack  = 0
  end

  def hajime
    @stack += 1
    raise SystemStackError if @stack > 17000
    snack

    directions = @input.join[/\d+x\d+/]

    if directions
      entries, n = *directions.split("x").map(&:to_i)

      (directions.length + 2).times { @input.shift }

      @input.unshift *(@input.first(entries) * (n-1))

      hajime()
    end
  rescue SystemStackError
    puts "#{@input.length} remain... better re-up on soy sauce."
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
        when nil
          @output += @input.length
          @input = []
        else
          @output += o
          @input.shift o
        end
      end
    end
end

def run_solution(puzzle)
  s = SushiChef.new(puzzle.chars)
  loop do
    s.hajime

    break if s.input.empty?

    input, output = s.input, s.output
    s = SushiChef.new(s.input, s.output)
  end

  puts "☃ Thank you, have a nice day ☃"
  puts s.output
  puts "☃ Thank you, have a nice day ☃"
end

run_solution(input)

#%w{
#  (3x3)XYZ
#  X(8x2)(3x3)ABCY
#  (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN
#  (27x12)(20x12)(13x14)(7x10)(1x12)A
#}.each {|s| run_solution(s) }
