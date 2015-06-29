class Like < ActiveRecord::Base
	has_many :users
	belongs_to :status
end