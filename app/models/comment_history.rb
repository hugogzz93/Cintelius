class CommentHistory < ActiveRecord::Base
	belongs_to :commentable_history, polymorphic: true

	# validates :content, presence: true, length: {maximum: 500}
end
