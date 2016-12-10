lines = File.readlines(File.dirname(__FILE__) + "/input").map {|line| line.rstrip }

module Sequencing
  def abas
    filtered_strings.map {|string| string.each_char.each_cons(3).select { |x| x == x.reverse && x[0] != x[1] } }.flatten(1).map(&:join)
  end

  def has_an_abba?
    @strings.any? {|string| string.each_char.each_cons(4).map(&:join).any? { |x| x[0..1] != x[2..3] && x == x.reverse } }
  end
end

class IPv7
  def initialize(string)
    @string = string
  end

  def supernet
    @supernet ||= Supernet.new(@string)
  end

  def hypernet
    @hypernet ||= Hypernet.new(@string)
  end

  def supports_tls?
    supernet.has_an_abba? && !hypernet.has_an_abba?
  end

  def supports_ssl?
    has_a_bab_with_aba?
  end

  def has_a_bab_with_aba?
    habas = hypernet.abas
    sabas = supernet.abas.map{ |bab| bab.gsub(/[#{bab[0..1]}]/, bab[0] => bab[1], bab[1] => bab[0]) }

    (habas & sabas).length > 0
  end
end

class Hypernet
  include Sequencing
  def initialize(string)
    @strings = string.scan(/\[\w+\]/).map { |s| s[1..-2] }
  end

  def filtered_strings
   @strings
  end
end

class Supernet
  include Sequencing
  def initialize(string)
    @strings = [string]
  end

  def filtered_strings
    #@strings.map {|s| s.gsub(/[\[\]]/, "[" => "<", "]" => ">") }
    [@strings[0].split(/\[\w+\]/).join]
  end
end

puts lines.map {|x| IPv7.new(x) }.count(&:supports_tls?)
puts lines.map {|x| IPv7.new(x) }.count(&:supports_ssl?)
