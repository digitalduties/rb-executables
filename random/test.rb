anagrams = ["eat", "tea", "tan", "ate", "nat", "bat"]

grouped = Hash.new { |hash, key| hash[key] = [] }

anagrams.each do |word|
  key = word.chars.sort.join
  grouped[key] << word
end

result = grouped.values
puts result.inspect