class CreateLabelings < ActiveRecord::Migration
  def change
    create_table :labelings do |t|
#created a column which will have the name lablelable_id using t.references :lablelable
#use polymorphic: true which adds a type column called lablelable_type to associate labeling with different objects
      t.references :label, index: true
      t.references :labelable, polymorphic: true, index: true
      t.timestamps null: false
  end
       add_foreign_key :labelings, :labels
    end
  end
