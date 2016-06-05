require 'spec_helper'
require 'p2_enumerable_methods'

describe "Enumberable" do
 describe ".my_each_with_index" do
 	context "given empty array" do
 		it "returns nil" do
 			expect([].my_each_with_index).to eql(nil)
 		end
 	end
 	context "given array of elements" do
 		let(:input_array) {["x","xx","y","yz"]}
 		it "iterates over every object in the array with index" do
 			input_array.my_each_with_index do |value, index| 
      			input_array[index] == value
    		end
 		end
 	end
 end
 describe ".my_select" do
 	context "given empty array" do
 		it "returns empty array" do
 			expect([].my_select{ |num|  num.even?  }).to eql([])  
 		end
 	end
 	context "given empty block" do
 	 	let(:input_array) {["x","xx","y","yz"]}
 		it "returns source array" do
 			expect(input_array.my_select).to eql(input_array)  
 		end
 	end
 	context "given array of elements" do
 		it "returns array of values for which block is true" do
 			expect([1,2,3,4,5].my_select{ |num|  num.even?  }).to eql([2,4])  
 		end
 	end
 end
 describe ".my_any?" do
 	context "given input" do
 		it "returns true" do
 			expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be_truthy 
 		end
 	end
 	context "given input" do
 		it "returns false" do
 			expect(%w{ant bear cat}.my_any? { |word| word.length == 5 }).to be_falsey  
 		end
 	end
 end
 describe ".my_count" do
 	context "given input" do
 		let(:ary) {[1, 2, 4, 2]}
 		it "returns count value" do
 			expect(ary.my_count).to eql(4)
 		end
 	end
 	context "given input" do
 		let(:ary) {[1, 2, 4, 2]}
 		it "returns count value" do
 			expect(ary.my_count{ |x| x%2==0 }).to eql(3) 
 		end
 	end
 	context "given input" do
 		let(:ary) {[1, 2, 4, 2]}
 		it "returns count value" do
 			expect(ary.my_count(2)).to eql(2) 
 		end
 	end
 end
end