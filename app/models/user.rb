class User < ActiveRecord::Base
	def self.authenticate(email, password)
		@user = User.new
		@user.email = email
		@user.password = password
		@auth = User.find_by_email(email)
		if @auth == nil
			return nil
		elsif (@auth.password == password) && (@auth.email == email)
			return @auth
		end
	end
end