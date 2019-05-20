# CreateUserChallenges
class CreateUserChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :user_challenges do |t|
      t.integer :user_id
      t.integer :challenge_id

      t.timestamps null: false
    end
  end
end
