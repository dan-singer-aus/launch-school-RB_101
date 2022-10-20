# Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

puts flintstones.bsearch_index { |name| name.start_with?('Be') }
