columns = File.readlines(File.dirname(__FILE__) + "/input").map {|line| line.rstrip.chars }.transpose

puts columns.map { |column|
  content = column.group_by{ |char| column.count(char) }

  [
    content[content.keys.min][0],
    content[content.keys.max][0]
  ]
}.transpose.map(&:join).reverse
