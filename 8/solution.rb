commands = File.readlines(File.dirname(__FILE__) + "/input").map {|line| line.rstrip }

height = 6
width  = 50

grid   = Array.new(width, Array.new(height, false))

def spin_cog(grid, index, amount) # neato!
  grid[index] = grid[index].rotate(-amount)

  grid
end

commands.each do |command|
  case command
  when /\Arect/
    fill_x, fill_y = *command.scan(/\d+/).map(&:to_i)
    puts "#{fill_x}x#{fill_y}"
    grid = grid.transpose
    grid = grid.each.with_index.map { |row, index| index < fill_y ? row.fill(true, 0..(fill_x - 1)) : row }
    grid = grid.transpose
  when /\Arotate row/
    index, amount = *command.scan(/\d+/).map(&:to_i)

    grid = grid.transpose
    grid = spin_cog(grid, index, amount)
    grid = grid.transpose
  when /\Arotate column/
    index, amount = *command.scan(/\d+/).map(&:to_i)

    grid = spin_cog(grid, index, amount)
  end
end

puts grid.inject(0) {|sum,row| sum += row.count(true) }

grid.transpose.each do |row|
  row.each {|x| $stdout.print(x ? "@@" : "  "); $stdout.flush }
  puts nil
end
