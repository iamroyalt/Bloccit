class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
#public is set to true so that public is the default
      t.boolean :public, default: true
      t.text :description

      t.timestamps null: false
    end
  end
end
