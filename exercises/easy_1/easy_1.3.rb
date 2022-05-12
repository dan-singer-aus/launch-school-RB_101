def digit_list(nums)
  arr = nums.digits
  arr.reverse
end
p digit_list(12345)  # => true
p digit_list(7)              # => true
p digit_list(375290)# => true
p digit_list(444)
