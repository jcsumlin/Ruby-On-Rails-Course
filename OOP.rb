class Student
	# Classes have instance variables 
	@first_name
	@last_name
	@email
	@username
	@password
	

	# when printing a class object it will default to using this method.
	# We can overwrite its functionality here
	def to_s
		"first_name: #{@first_name}"
	end

end

# initialize a new Student object from class
student = Student.new

