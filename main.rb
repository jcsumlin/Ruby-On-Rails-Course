address = [1, 2, 3, 4, 5, 6, 7, 8, 9]
p address.reverse!


say = 'I love Ruby'
puts say
print say
p say

say['love'] = "*love*"


def say_hello(arguement)
	puts arguement
end

say_hello(10)



#string Concatonation 
first_name = "Chat"
last_name = "Sumlin"
puts first_name + " " + last_name

#String interpolation
 puts "My name is #{first_name} #{last_name}"
#Method 

def add(number1, number2)
	number1 + number2 # returns are the last line of a function
end

p add(1,2)
puts address # prints each array item on a new line

puts "#### Ranges ####"
x = 1..100 # Range from 1 to 100
puts x 
puts x.class
x.to_a # Range to array
x.to_a.shuffle # shuffle an array

x.to_a.reverse! # mutating the result of to_a not x itself

y = "a".."z" # you cant chain the to_a method on Ranges
y = y.to_a # array of letters a-z

y << "0" #shovel operator addes to the end of the array
y.unshift("Chat") # adds item to the beginning to the array
y.append("0") #append also adds to the end of an array

y.uniq # strips duplicates from array
y.empty? # bool. is the var empty
y.include?("Chat") #checks if an element is in an array
y.push("new items") #puts a new item at the end of the array
last = y.pop() #returns the last item in an array and removes it from the array
y.join # returns a string of all the elements in an array
b = y.join("-") # same as the above but adding a - between each element
b = b.split("-") #splits a string by a designated element and returns an array


p %w(my name is chat) #At


### ITTERATORS ###
# .each() operator is the prefered itterator in Ruby
# For loops work too
for i in b
	print i
end
#each method in action
b.each do |letter|
	p letter
end
#each method is usually used on one line
b.each {|letter| print letter.capitalize + " "}

# Select operators work with booleans
#itterate through array to test a boolean statement and retunrn all the results in array

a = (1..100).to_a.shuffle
odd_numbers = a.select {|number| number.odd?}

## deck of cards

numbers = (1..10).to_a
suits = ["Hearts", "Clubs", "Spades", "Diamonds"]
suits = ["Hearts", "Clubs", "Spades", "Diamonds"]
high_cards = ["Jack", "Queen", "King", "Ace"]
cards = numbers + high_cards
deck = []
for suit in suits
	cards.each {|n| deck.append("#{n} of #{suit}")}
end
deck.shuffle!

# Deal 2 cards 
p deck.pop
p deck.pop


##### HASHES aka Dictionaries #####

simple_hash = {"a" => 1, "b" => 2}
# {"a"=>1, "b"=>2}
# a,b,c are symbols not strings in another_hash
another_hash = {a:1, b:2, c:3}
# {:a=>1, :b=>2, :c=>3}
p another_hash[:a] # 1

#.keys returns all the keys as an array
#.values returns all the values as an array

another_hash.each do |key, value|
	puts "The class for key is #{key.class} and the value is #{value}"
end

my_hash = {a:1, b:2, c:3, d:"Test"}
my_hash.each { |key, value| puts "The sky is #{key} the value is #{value}" }
# Returns the sub-hash where the values are all strings 
puts my_hash.select {|key, value| value.is_a?(String)}
#to delete something from a hash you only have to delete the key
puts my_hash.each { |key, value| my_hash.delete(key) if value.is_a?(String) }

#### Authentication Project #####
users = [
	{username: "chat", password: "pass"}
]

puts "Welcome to the Authentication Project"
25.times {print "-"}
puts
puts "Please enter a username"

def auth_user(username, password, list_of_users)
	list_of_users.each do |user|
		if user[:username] == username && user[:password] == password
			return user
		end
	end
	return "Username and password do not match records"
end


attempts = 0
while attempts < 3
	
	print "Username: "
	username = gets.chomp
	print "Password: "
	password = gets.chomp
	puts auth_user(username, password, users)
	puts "Press n to quit or anyother key to continue: "
	input = gets.chomp.downcase
	break if input == "n"
	attempts += 1
end