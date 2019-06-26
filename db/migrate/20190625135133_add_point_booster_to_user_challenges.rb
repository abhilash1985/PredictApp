# AddPointBoosterToUserChallenges
class AddPointBoosterToUserChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :user_challenges, :point_booster, :boolean, default: false
    add_index :user_challenges, :point_booster
  end
end
