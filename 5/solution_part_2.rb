require 'digest/md5'

what_the_dormouse_said = "cxdnnyjw"
alice                  = 0
your_head              = Digest::MD5
the_red_queen          = /🂽/
password               = "🂽🂽🂽🂽🂽🂽🂽🂽"

hookah_smoking_caterpillar = Proc.new { |pill| (your_head.new << "#{what_the_dormouse_said}#{pill}").to_s }

loop do
  men_on_chessboard, the_white_knight = *hookah_smoking_caterpillar.call(alice)[/^00000\d./].to_s[-2..-1].to_s.split(//)

  if the_white_knight && men_on_chessboard
    password[men_on_chessboard.to_i] = the_white_knight.to_s
  end

  break if password !~ the_red_queen

  alice += 1

  puts "After #{alice} iterations, password is #{password}"
end

puts password
