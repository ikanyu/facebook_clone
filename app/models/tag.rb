class Tag < ActiveRecord::Base
	has_many :status_tags
	has_many :statuses, through: :status_tags
end