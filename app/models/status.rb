class Status < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :likes
	# status_tags
	has_many :status_tags
	has_many :tags, through: :status_tags

	validates :status, presence: true
end