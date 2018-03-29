# def my_min(arr)
#   arr.each do |el|
#     smallest = true
#     arr.each do |el2|
#       smallest = false if el > el2
#     end
#     return el if smallest
#   end
# end

def my_min (arr)
  smallest = arr.first
  arr.each.with_index do |el, index|
    next if index == 0
    smallest = el if el < smallest
  end
  smallest
end



# def largest_contiguous_subsum(arr)
#   subs = []
#   arr.each.with_index do |el, index|
#     arr.each.with_index do |el2, index2|
#       next if index2 < index
#       subs << arr[index..index2]
#     end
#   end
#
#   sums = []
#   subs.each do |sub_arr|
#     sums << sub_arr.reduce(&:+)
#   end
#   sums.max
# end

def largest_contiguous_subsum(arr)

  all_negative_arr = arr.all? {|el| el < 0}
  if all_negative_arr
    largest = arr[0]
    arr.each {|el| largest = el if el > largest}
    largest
  else
    largest = arr[0]
    current_sum = largest
    arr.each.with_index do |el, index|
      next if index == 0
      current_sum += el
      largest = current_sum if current_sum > largest
      current_sum = 0 if current_sum < 0
    end
    largest
  end
end

if __FILE__ == $PROGRAM_NAME
     list = [-5, -1, -3]
 p largest_contiguous_subsum(list)

end
