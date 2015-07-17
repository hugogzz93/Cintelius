class CreateCommentHistory < ActiveRecord::Migration
  def change
    create_table :comment_histories do |t|
	    t.integer  :commentable_history_id,   limit: 4
	    t.string   :commentable_history_type, limit: 255
	    t.text     :content,          limit: 65535, null: false
	    t.datetime :created_at,                     null: false
	    t.datetime :updated_at,                     null: false
	end
  end
end
