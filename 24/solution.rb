require 'pry'

class World
  attr_accessor :map
  def initialize(file)
    inp  = File.read(file)
    puts inp
    inp  = inp.rstrip.scan /.+/

    @map = {}
    inp.each_with_index {|row,y| row.each_char.with_index {|char,x| @map[Complex(x,y)] = char } }
  end

  def destinations
    map.select {|k,v| v[/\d+/] }.keys - [home]
  end

  def home
    map.detect {|k,v| v == "0" }[0]
  end
end

class WorldTraveler
  def initialize(grid)
    @grid = grid
    @known_traversals = {}
  end


  def travel_time(start, finish = nil)
    @known_traversals.fetch([start,finish]) {
      frontier  = [] << start
      came_from = {}

      came_from[start] = nil

      while !frontier.empty? do
        current = frontier.shift

        neighbors(current).each do |n|
          unless came_from.has_key? n
            frontier << n
            came_from[n] = current
          end
        end
      end

      current = finish
      path    = []
      while current != start do
        path << current
        current = came_from[current]
      end

      @known_traversals[[start,finish]] = path.length
    }
  end

  private

  def neighbors(coord)
    [
      coord + (0+1i), # Up
      coord + (0-1i), # Down
      coord + (1-0i), # Right
      coord - (1+0i), # Left
    ].select do |c|
      @grid.fetch(c) { "#" } != "#"
    end
  end
end

class TravelAgent
  def initialize(world, first_class = WorldTraveler)
    @world       = world
    @first_class = first_class.new(world.map)
  end

  def whats_the_damage?
    @world.destinations.permutation(@world.destinations.length).each.map { |schedule|
      @first_class.travel_time(@world.home, schedule[0]) +
      schedule.each_cons(2).map {|leg|
        @first_class.travel_time(leg.first, leg.last)
      }.sum
    }.min
  end
end

world = World.new("test_input.txt")
print "Sample: "
puts TravelAgent.new(world).whats_the_damage?

world = World.new("input.txt")
print "P1: "
puts TravelAgent.new(world).whats_the_damage?
