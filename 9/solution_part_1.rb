# Read the input
require 'benchmark'
input  = File.read(File.dirname(__FILE__) + "/input").rstrip

class SushiChef
  def initialize(input)
    @input = input
    @output = String.new
  end

  def hajime
    snack

    directions = @input.join[/\d+x\d+/]

    if directions
      entries, n = *directions.split("x").map(&:to_i)

      (directions.length + 2).times { @input.shift }

      n.times { @output += @input.first(entries).join }
      entries.times { @input.shift }

      hajime()
    end
  end

  def output
    @output
  end

  private

    def snack
      loop do
        break if @input.empty? || @input[0] == "("
        @output += @input.shift
      end
    end
end

def run_solution(puzzle)
  s = SushiChef.new(puzzle.chars)

  s.hajime

  puts "☃ Thank you, have a nice day ☃"
  puts s.output.length
  puts "☃ Thank you, have a nice day ☃"
end

run_solution(input)

puts Benchmark.measure {
 %w{
  (3x3)XYZ
  X(8x2)(3x3)ABCY
  (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN
 }.each {|s| run_solution(s) }
  #(27x12)(20x12)(13x14)(7x10)(1x12)A
}
