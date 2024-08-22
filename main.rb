require_relative 'lib/hash_map'

test = HashMap.new

p test.entries
test.set('apple', 'red') # bucket 10
test.set('banana', 'yellow') # bucket 5
test.set('apple', 'green') # OVERWRITE bucket 10
test.set('carrot', 'orange') # bucket 3
test.set('dog', 'brown') # bucket 12
test.set('elephant', 'gray') # bucket 1
test.set('frog', 'green') # bucket 4
test.set('grape', 'purple') # bucket 11
test.set('hat', 'black') # COLLISION bucket 11
test.set('ice cream', 'white') # bucket 13
test.set('jacket', 'blue') # bucket 14
test.set('kite', 'pink') # bucket 15
test.set('lion', 'golden') # COLLISION bucket 12
test.set('elephant', 'blue') # OVERWRITE bucket 1
p test.entries
test.to_string(11)
test.to_string(12)

p test.length

test.set('moon', 'silver')
p test.entries
p test.length
test.set('ice cream', 'pink')
p test.entries
p test.values
puts 'key is lion, value is ? : '
p test.get('lion')
p test.has?('lion')
p test.has?('lionness')
p test.has?('grape')
p test.entries
p test.remove('grape')
p test.entries
test.clear
p test.entries