class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true

	validates :content, presence: true, length: {maximum: 500}
end
