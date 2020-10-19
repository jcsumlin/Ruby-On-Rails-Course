class Student
	## GETTER AND SETTERS ##
	# Ruby provides a convient way to have getter and setter methods without copy and pasting code.
	attr_accessor :first_name, :last_name, :email
	# the above is equivelent to defining get and set methods for each of the instance variables

	#only allows the getter methods not the setter methods
	attr_reader :username


	# Classes have instance variables 
	@first_name
	@last_name
	@email
	@username
	@password

	# set up a class object in one go
	def initialize(first_name, last_name, email)
		@first_name = first_name
		@last_name = last_name
		@email = email
	end
	
	# # Setter notion. Allows us to use Student.first_name = "string"
	# def first_name=(name)
	# 	@first_name = name
	# end

	# # Getter notion. Allows us access to specific class variables
	# def first_name
	# 	@first_name
	# end

	 


	# when printing a class object it will default to using this method.
	# We can overwrite its functionality here
	def to_s
		"First name: #{@first_name}, Last Name #{@last_name}, Email #{email}"
	end

end

# initialize a new Student object from class
# student = Student.new
# student.first_name = "Chat"
# puts student
# puts student.first_name

new_student = Student.new("Chat", "Sumlin", "jcsumlin@pm.me")
puts new_student
new_student.first_name = "John"
puts new_student


