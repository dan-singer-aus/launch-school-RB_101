munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has 
#   an additional "age_group" key that has one of three values describing
#  the age group the family member is in (kid, adult, or senior). 

munsters.each_pair do |key, val|
  if val["age"] <= 17
    val["age group"] = 'kid'
  elsif val["age"] <= 64
    val["age_group"] = 'adult'
  else
    val["age_group"] = 'senior'
  end
end

munsters.each {|deets| puts deets }