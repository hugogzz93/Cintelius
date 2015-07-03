class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true

	# before_destroy :create_history

	def create_history_recursively(commentable_object)
		history_object_hash = self.attributes
		history_object_hash.delete("id")
		history_object_hash.delete("commentable_id")
		history_object_hash.delete("commentable_type")
		history_object_hash["commentable_history_id"] = commentable_object.id
		history_object_hash["commentable_history_type"] = commentable_object.class.name
		CommentHistory.create(history_object_hash)
	end

	# validates :content, presence: true, length: {maximum: 500}
end
