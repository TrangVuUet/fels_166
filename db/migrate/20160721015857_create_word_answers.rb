class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.string :content
      t.boolean :is_correct
      t.references :word, foreign_key: true
      t.timestamps
    end
    add_index :word_answers, [:word_id, :created_at]
  end
end
