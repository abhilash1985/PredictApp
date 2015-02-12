class AddWeightageToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :weightage, :integer
    add_index :questions, :weightage
  end
end
