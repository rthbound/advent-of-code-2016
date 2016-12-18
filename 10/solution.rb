input  = File.readlines(File.dirname(__FILE__) + "/input")

begin
  require "bundler/inline"
rescue LoadError => e
  $stderr.puts "Bundler version 1.10 or later is required. Please update your Bundler"
  raise e
end

gemfile(true) do
  source "https://rubygems.org"

  gem "pay_dirt"
  gem "activesupport"
end

require 'pay_dirt'
require 'active_support'

ActiveSupport::Notifications.subscribe('compare') do |name, start, finish, id, payload|
  puts payload.inspect if payload[:comparing] == [17, 61]
end


class BotNetwork < PayDirt::Base
  def initialize(options = {})
    options = {
      bots:      [],
      output:    [],
      bot_class: Ambotdextrous,
    }.merge! options

    load_options(options)
  end

  def call(commands)
    commands.each do |command|
      case command
      when /^bot/
        commands = command.scan(/^bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/).flatten
        proceed *commands
      when /^value/
        issue_value *command.scan(/\d+/)
      else
        raise "Beep beep blorp"
      end
    end
  end

  def output
    @output
  end


  def bots
    @bots
  end

  private

    def issue_value(v, b)
      bot(b).take(v)

      procession(bot(b))
    end

    def procession(robot)
      if robot.ready? && robot.procession != nil
        proceed(*robot.procession)
      end
    end

    def issue_command(b, c, n)
      case c
      when /bot/
        bot(n).take  bot(b).unload

        procession(bot(n))
      when /output/
        @output[n.to_i] = bot(b).unload
      end
    end

    def bot(name)
      bots.detect { |b| b.name == name } || create_bot(name)
    end

    def proceed(b, c1, n1, c2, n2)
      if bot(b).ready?
        bot(b).tap do |b0|
          issue_command b, c1, n1
          issue_command b, c2, n2
        end
      else
        bot(b).procession = [b, c1, n1, c2, n2]
      end
    end

    def create_bot(name, hands = 2)
      register_bot @bot_class.new(name: name)
    end

    def register_bot(bot)
      @bots[@bots.length] = bot
    end
end

class Ambotdextrous < PayDirt::Base
  def initialize(options = {})
    options = {
      values: [],
      value_history: []
    }.merge! options

    load_options(:name, options)
  end

  def procession=(arr)
    @procession = arr
  end

  def procession
    @procession
  end

  def value_history
    @value_history
  end

  def unload
    ActiveSupport::Notifications.instrument('compare', { comparing: values, name: name })
    values.shift
  end

  def take v
    @values << v.to_i
  end

  def ready?
   values.length == 2
  end

  def name
    @name
  end

  def values
    @values.compact!
    @values.sort!
  end

  private
end

b = BotNetwork.new
b.call(input)
puts b.output.first(3).inject(:*)
