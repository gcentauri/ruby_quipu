require_relative "khipu"

cord = Cord.new
puts "An empty cord =>\n#{cord}"

cord.colour = [255, 0, 0 , 255]
cord.concat([1, 2, 3, 4, 5])

puts "A red cord with knots =>\n#{cord}"

cord.direction = true

puts "A red cord facing up with knots =>\n#{cord}"

group = Group.new
puts "An group with an empty top cord =>\n#{group}"

group.add_to_top_cord(cord)
puts "A group with a knotted top cord =>\n#{group}"

group.top_cord.clear
group.append(cord)
puts "A group with top cord and red cord =>\n#{group}"

copy = group.copy
puts "A group and its copy =>\n#{group}\n#{copy}"

empty = Group.new(false)
puts "An empty group =>\n#{empty}"

copy.clear
copy.concat([cord, cord, cord])
puts "A group with several cords and a top cord =>\n#{copy}"

big_cord = cord.copy
big_cord += cord
copy.insert(0, big_cord)
puts "Group with big cord inserted up front =>\n#{copy}"

khipu = Khipu.new
khipu.concat [group, copy, cord, big_cord]
puts "A Khipu =>\n#{khipu}"
