class Comment < ActiveRecord::Base
	has_many :users
	belongs_to :status
end