class AddTopicToPosts < ActiveRecord::Migration[5.2]
 

  def change
    add_column :posts, :topic_id, :integer
     # ...we instructed the generator to create a migration that adds a topic_id column to the posts table.

    add_index :posts, :topic_id
    # we created an index on topic_id with the generator. An index improves the speed of operations on a database table.
    # You should always index your foreign key columns.

  end
end
