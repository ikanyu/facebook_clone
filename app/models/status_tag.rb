class StatusTag < ActiveRecord::Base
	belongs_to :status
	belongs_to :tag
end