def digit_list(nums)
  arr = nums.digits
  arr.reverse
end

p digit_list(12345)
p digit_list(7)
p digit_list(375290)
p digit_list(444)