# AddWeightageToQuestions
class AddWeightageToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :weightage, :integer
    add_index :questions, :weightage
  end
end
