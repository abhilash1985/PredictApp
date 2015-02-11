class CreateMatchQuestions < ActiveRecord::Migration
  def change
    create_table :match_questions do |t|
      t.integer :match_id
      t.integer :question_id
      t.text :options
      t.string :answer
      t.integer :points

      t.timestamps null: false
    end
  end
end
