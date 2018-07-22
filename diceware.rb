# Simple generator to make Diceware passwords
# See http://world.std.com/~reinhold/diceware.html for explanation on Diceware
require 'securerandom'
password_length = ARGV[0] ? ARGV[0].to_i : 5
wordlist = ARGV[1] ? ARGV[1] : "wordlist.txt"

DELIMITERS = ["!","#","$","%","^","&","*","?","|"]

# Create a hash of numbers and words from supplied wordlist
words = File.open(wordlist, "r") do |f|
  Hash[f.each_line.map { |l| l.chomp.split(" ", 2) }]
end

# Initialize and empty array and then populate it with
# sampled words from the word array
password_array = []
password_length.times do
  password_array << words[words.keys.sample]
end

# Sample a delimiter
delimiter = DELIMITERS.sample

# Print out new password, joined and with sampled delimiter
puts "Your Diceware generated password is: \n" + password_array.join(delimiter)