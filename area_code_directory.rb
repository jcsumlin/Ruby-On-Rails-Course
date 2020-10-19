dial_book = {
	"newyork" => 212
}

def get_city_names(hash)
	hash.each do |city, code|
		puts city
	end
end

def get_area_code(hash, selection)
	hash.each do |city, code|
		if selection == city
			return "The area code for #{city} is #{code}"
		end
	end
	return "You entered an invalid selection"
end

loop do
	puts "Do you want to look up an area code? (Y/N)"
	answer = gets.chomp.downcase
	break if answer == 'n'
	get_city_names(dial_book)
	puts "Enter your selection"
	selection = gets.chomp.downcase
	puts get_area_code(dial_book, selection)
end

# See if a key is inside a hash's keys
puts dial_book.include?("newyork") # true