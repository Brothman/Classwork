def bad_two_sum?(arr, target)
  (0..arr.length - 2).each do |i|
    (i + 1..arr.length - 1).each do |j|
      return true if arr[i] + arr[j] == target
    end
  end
  false
end

#this is O(n^2) time complexity

# arr = [0, 1, 5, 7]
# p bad_two_sum?(arr, 6) # => should be true
# p bad_two_sum?(arr, 10) # => should be false

def okay_two_sum?(arr, target)
  sorted_arr = arr.sort
  sorted_arr.each do |el|
    search_val = target - el
    return true if sorted_arr.bsearch {|x| x == search_val && x!= el}
  end
  false
end

#this would be O(n log(n)) because bsearch is log(n) complexity and
#we do this n times wit the each loop

# arr = [0, 1, 5, 7]
# p okay_two_sum?(arr, 6) # => should be true
# p okay_two_sum?(arr, 10)

def good_two_sum?(arr, target)
  counter_hash = Hash.new(0)
  arr.each do |el|
    counter_hash[el] += 1
  end

  arr.each do |el|
    search_val = target - el
    if counter_hash[search_val] && search_val==el
      return true if counter_hash[search_val] >= 2
    elsif counter_hash[search_val] > 0
      return true
    end
  end
  false
end # this would O(n) time

arr = [0, 1, 5, 7]
p good_two_sum?(arr, 6) # => should be true
p good_two_sum?(arr, 10)
