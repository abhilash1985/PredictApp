# AddPaidToUserChallenges
class AddPaidToUserChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :user_challenges, :paid, :boolean, default: false
  end
end
