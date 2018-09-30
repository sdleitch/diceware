#!/usr/bin/env ruby
# Simple generator to make Diceware passwords
# See http://world.std.com/~reinhold/diceware.html for explanation on Diceware

require "optparse"

class DicewarePassword
  attr_reader :value
  def initialize(options)
    @value = self.generate(options)
  end

  def generate(opts)
    length = opts[:number] || 5
    delimiter = opts[:no_delimiter] ? "" : (opts[:delimiter] || ["!","#","$","%","^","&","*","?","|"].sample)
    wordlist = opts[:wordlist] || "wordlist.txt"
    
    # Read words from wordlist into Array
    words = File.readlines(wordlist)
    # Initialize an empty Array and then populate it with
    # sampled words from the words Array
    password_array = []
    length.times { password_array << words.sample.chomp }
    # Join those words with delimiter
    password_array.join(delimiter)
  end
end

options ={}
OptionParser.new do |opts|
  opts.banner = "Usage: diceware.rb [options]"
  opts.on("-n N", "--number N", Integer, "Number of words to use. Defaults to 5") { |n| options[:number] = n}
  opts.on("-d CHAR", "--delimiter CHAR", String, "Character to use as delimiter") { |d| options[:delimiter] = d }
  opts.on("--no-delimiter", "Don't include a delimiter character between words.") { |del| options[:no_delimiter] = true }
  opts.on("-w FILE", "--wordlist FILE", String, "Wordlist to use.", "Should be formatted as a single word on each line.", "Defaults to wordlist.txt") do |w|
    options[:wordlist] = w
  end
  opts.on("-h", "--help", "Show this help message") { puts opts; exit }
end.parse!

password = DicewarePassword.new(options) 
puts password.value
