# Simple generator to make Diceware passwords
# See http://world.std.com/~reinhold/diceware.html for explanation on Diceware

# Create empty hash to store vales and words later
words = Hash.new

# Generate hash of number keys and word values from wordlist.txt
File.open('wordlist.txt', 'r') do |f|
  f.each_line do |line|
    # If the line starts with a six-digit number and each digit is between 1 and 6..
    if /^[1-6]{5}\s/ =~ line
      # ..add it to the hash with the number as the key and word as the value
      words[line[0..4].to_i] = line[6..line.length].chomp
    end
  end
end

numbers = []
# Generate random number between 11,111 and 66,666
# Check if that's a possible roll (if it's in the hash)
# If it is, add it to the numbers array
until numbers.length == 5  do
  num = rand(11111..66666)
  if words[num] != nil
    numbers << num
  end
end

# Match the number with the corresponding value in the Words hash
# Add that word to the passwordArray
passwordArray = Array.new
numbers.each do |num|
  passwordArray << words[num]
end

# Print out new password, joined and with spaces
puts "Your Diceware generated password is: \n" + passwordArray.join(' ')
