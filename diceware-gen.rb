# Simple generator to make Diceware passwords
# See http://world.std.com/~reinhold/diceware.html for explanation on Diceware

File.open('wordlist.txt', 'r') do |f|
  words = Hash.new
  # generate hash of number keys and word values from wordlist.txt
  f.each_line do |line|
    if /^[1-6]{5}\s/ =~ line
      # puts line[0..4]
      words[line[0..4].to_i] = line[6..line.length].chomp
    end
  end
end
