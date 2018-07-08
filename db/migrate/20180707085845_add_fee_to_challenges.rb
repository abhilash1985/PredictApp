# AddFeeToChallenges
class AddFeeToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :fee, :integer, default: 10
    add_index :challenges, :fee
  end
end
