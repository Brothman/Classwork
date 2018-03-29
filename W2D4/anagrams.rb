require 'byebug'
def first_anagram?(str1, str2)
  # letter_arr = str1.chars
  # anagram_arr = []
  #
  # letter_arr.each_with_index do |el, i|
  #   anagram = el
  #   letter_arr.each_with_index do |el2, j|
  #     next if i == j
  #     el += el2
  #   end
  # end

  anagram_arr = anagrams(str1)
  anagram_arr.include?(str2)
end

def anagrams(str)
  if str.length <= 2
     [str[0..1], str[0..1].reverse]
  else
    current_str = str[-1]
    my_anagarms = anagrams(str[0...-1])
    return_anagrams = []

    my_anagarms.each do |str|
      (0..str.length).each do |i|
        #debugger
        return_anagrams << str[0...i] + current_str + str[i..-1]
      end
    end
    return_anagrams
  end
end


# p first_anagram?("hello", "elhol")

def second_anagram?(str1, str2)
  str1_arr = str1.chars
  str2_arr = str2.chars

  str1_arr.each do |letter|
    str2_arr.delete_at(str2_arr.index(letter) || str2_arr.length)
  end

  str2_arr.empty?

end
'abcde', 'abc'
def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end

def fourth_anagram?(str1, str2)
  str1_hash = Hash.new(0)
  str2_hash = Hash.new(0)

  str1.chars.each do |letter|
    str1_hash[letter] += 1
  end

  str2.chars.each do |letter|
    str2_hash[letter] += 1
  end

  str1_hash == str2_hash
end

p fourth_anagram?("hello", "elhol")
p fourth_anagram?("hello", "eltol")
