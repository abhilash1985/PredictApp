# frozen_string_literal: true

# CreateQuestionOptions
class CreateQuestionOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :question_options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :option4
      t.string :option5
      t.string :option6
      t.string :option7
      t.string :option8
      t.string :option9
      t.string :option10

      t.timestamps
    end
  end
end
