class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer
#adds a topic_id column to the posts table.
    add_index :posts, :topic_id
#index improves the speed of operations on a database table.    
  end
end
