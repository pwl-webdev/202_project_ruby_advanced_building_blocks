def bubble_sort(input)
	not_sorted = true
	while not_sorted do
		no_of_swaps = 0 
		input.each_index do |index|
			if input[index] != nil && input[index+1] != nil
				if input[index+1] < input[index] 
					temp = input[index]
					input[index] = input[index+1]
					input[index+1] = temp
					no_of_swaps += 1
				end
			end
		end
		if no_of_swaps == 0
			not_sorted = false
		end
	end
	return input
end

 #puts bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(input)
	not_sorted = true
	while not_sorted do
		no_of_swaps = 0 
		input.each_index do |index|
			if input[index] != nil && input[index+1] != nil
				if yield(input[index], input[index+1]) > 0 
					temp = input[index]
					input[index] = input[index+1]
					input[index+1] = temp
					no_of_swaps += 1
				end
			end
		end
		if no_of_swaps == 0
			not_sorted = false
		end
	end
	puts input
	return input
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
   left.length - right.length
end