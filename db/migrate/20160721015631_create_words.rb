class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.references :category, foreign_key: true
      t.timestamps
    end
    add_index :words, [:category_id, :created_at]
  end
end
