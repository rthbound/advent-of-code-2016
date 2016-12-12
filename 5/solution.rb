require 'digest/md5'

what_the_dormouse_said = "cxdnnyjw"
alice                  = 0
your_head              = Digest::MD5
password               = String.new

hookah_smoking_caterpillar = Proc.new { |pill| (your_head.new << "#{what_the_dormouse_said}#{pill}").to_s }

loop do
  the_white_knight = hookah_smoking_caterpillar.call(alice)[/^00000./].to_s[-1]

  password << the_white_knight.to_s

  break if password.length === 8

  alice += 1
end

puts password
