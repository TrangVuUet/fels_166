class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :action_type
      t.integer :target_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
