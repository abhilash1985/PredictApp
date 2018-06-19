# AddPaidToUserChallenges
class AddPaidToUserChallenges < ActiveRecord::Migration
  def change
    add_column :user_challenges, :paid, :boolean, default: false
  end
end
