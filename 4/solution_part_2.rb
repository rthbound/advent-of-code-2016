lines = File.readlines(File.dirname(__FILE__) + "/input").map(&:rstrip)
sum   = 0
alphabet = "a".upto("z").to_a

# lines = %w{
#   aaaaa-bbb-z-y-x-123[abxyz]
#   a-b-c-d-e-f-g-h-987[abcde]
#   not-a-real-room-404[oarel]
#   totally-real-room-200[decoy]
# }

lines.each do |line|
  alphabeticals = line[/.*\[/].delete("-[")[/[a-z]*/].split(//)
  sector_id     = line[/-\d+\[/].delete("-[")

  content = alphabeticals.group_by{|x| alphabeticals.count(x)}.map {|x| [ x[0], x[1].uniq.sort ] }.sort.reverse.to_h.values.flatten.first(5).join
  cksum   = line[/\[\w+\]/].delete("[]")

  if content == cksum
    sum += sector_id.to_i if content == cksum
    puts line.each_char.map { |c|
      if c =~ /[a-z]/
        alphabet.rotate(alphabet.rindex(c)).rotate(sector_id.to_i)[0]
      elsif c == "-"
        " "
      else
        c
      end
    }.join
  end
end
