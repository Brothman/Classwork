# def windowed_max_range(array, window_size)
#   max_range = (array[window_size-1] - array[0]).abs
#   array.each.with_index do |el, index|
#     break if (index + window_size - 1) == array.length
#     current_range = (el - array[index + window_size - 1]).abs
#     max_range = current_range if current_range > max_range
#   end
#   max_range
# end



def windowed_max_range(array, window_size)
  current_max_range = 0

  array.each.with_index do |el, index|
    break if (index + window_size - 1) == array.length
    window = array[index...index + window_size]
    max = window.max
    min = window.min
    current_max_range = (max - min) if (max - min) > current_max_range
  end
  current_max_range
end # Time complexity is O(n^2) -> each min and max iterates through the entire window array

p windowed_max_range([1, 3, 2, 5, 4, 8], 5)

def optimized_max_range(array,window_size)
  
end
