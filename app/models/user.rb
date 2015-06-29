class User < ActiveRecord::Base
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	validates :email, uniqueness: true
	has_many :statuses
	has_many :comments
	has_many :likes

	validates :email, uniqueness: true
	validates :email, presence: true
	validates :password, presence: true
	def check_password(password)
		if self.password == password
			true
		else
			false
		end
	end
end