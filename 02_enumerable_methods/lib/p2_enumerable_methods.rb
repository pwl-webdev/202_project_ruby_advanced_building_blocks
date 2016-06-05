module Enumerable
    def my_each
    num = 0
      while num < self.length
      	yield(self[num])
      	num += 1
      end
    end

    def my_each_with_index
    num = 0
      while num < self.length
      	yield(self[num], num)
      	num += 1
      end
    end

    def my_select
    	to_return = []
      if block_given?
      	self.my_each  do |x|  
      		if yield(x)
      			to_return << x
      		end
      	end
      end  
      if to_return == []
        return self
    	else
        return to_return
      end
    end

    def my_all?
    	to_return = true
    	self.my_each do |x|
    		if block_given?
    			result = yield(x)
	    		if (result == false || result.nil?)
	    			to_return = false
	    		end
	    	elsif !block_given? && (x == false || x == nil)
	    		to_return = false
	    	end
    	end
    	return to_return
    end

    def my_any?
    	to_return = false
    	self.my_each do |x|
    		if block_given?
    			result = yield(x)
	    		if (result)
	    			#puts "-->"+result.to_s
	    			to_return = true
	    		end
	    	elsif !block_given? && x
	    		to_return = true
	    	end
    	end
    	return to_return
    end

    def my_none?
    	to_return = false
    	self.my_each do |x|
    		if block_given?
    			result = yield(x)
	    		if (result)
	    			#puts "-->"+result.to_s
	    			to_return = true
	    		end
	    	elsif !block_given? && x
	    		to_return = true
	    	end
    	end
    	return !to_return
    end

    def my_count(*arg)
      num = 0
      counted = 0
      while num < self.length
      	if block_given?
      		#puts "# 1"
      		if yield(self[num])
      			counted += 1
      		end
      	elsif arg[0] != nil
      		#puts "# 2"
      		if self[num] == arg[0]
      			counted += 1
      		end
      	elsif self[num]
      		#puts "# 3"
      		counted += 1
      	end
      	num += 1
      end
      return counted
    end

    def my_map
    	to_return = []
    	self.my_each do |x|
    		if block_given?
    			to_return << yield(x)
    		else
    			to_return << x
    		end
    	end
    	return to_return
    end

    def my_inject(*init)
    	to_return = 0
    	if init[0] != nil
    		to_return = init[0]
    	end
    	self.each do |x|
    		to_return = yield(to_return, x)
    	end
    	return to_return
    end

    def my_map_with_proc
    	to_return = []
    	self.my_each do |x|
    		if block_given?
    			to_return << yield(x)
    		else
    			to_return << x
    		end
    	end
    	return to_return
    end

    def my_map_with_proc_block(to_proc)
    	to_return = []
    	self.my_each do |x|
    		if block_given? && to_proc
    			to_return << to_proc.call(yield(x))
    		elsif to_proc
    			to_return << to_proc.call(x)
    		else
    			to_return << x
    		end
    	end
    	return to_return
    end
end

def multiply_els(input)
	return input.my_inject(1) { |product, n| product * n }
end

#something = Proc.new{ |i| i*i*i }

# 1) Test my_each method
#["x","xx","y","yz"].my_each do |x|
#	puts x
#end
# 2) Test my_each_with_index method
#["x","xx","y","yz"].my_each_with_index do |x, y|
#	puts "index: "+y.to_s+" value: "+x
#end
# 3) Test my_select
# puts [1,2,3,4,5].my_select { |num|  num.even?  }
# 4) Test my_all?
#puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
#puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
#puts [nil, true, 99].my_all?                              #=> false
# 5) Test my_any?
#puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
#puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
#puts [nil, false, nil].my_any?                              #=> false
#puts %w{ant bear cat}.my_any? { |word| word.length == 5 } #=> false
# 6 Test my_none?
#puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
#puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
#puts [].my_none?                                           #=> true
#puts [nil].my_none?                                        #=> true
#puts [nil, false].my_none?                                 #=> true
#puts [nil, false, true].my_none?                           #=> false
# 7 Test my_count
#ary = [1, 2, 4, 2]
#puts ary.my_count               #=> 4
#puts ary.my_count(2)            #=> 2
#puts ary.my_count{ |x| x%2==0 } #=> 3
# 8 Test my_map
#puts [1,2,3,4].my_map { |i| i*i }      #=> [1, 4, 9, 16]
#puts [1,2,3,4].my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
#puts [1,2,3,4].my_map
# 9 Test my_inject
# Sum some numbers
# Same using a block and inject
#puts (5..10).my_inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
#puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# find the longest word
#puts multiply_els([2,4,5]) #=> 40
# 10 Test my_map with proc
#puts [1,2,3,4].my_map_with_proc(&something)     #=> [1, 4, 9, 16]
# 11 Test my_map_with_proc_block
#puts [1,2,3,4].my_map_with_proc_block(&something) {|i| i/2}     #=> [1, 4, 9, 16]
# This does not work: either I dont understand the instruction or the instruction is impossible to perform