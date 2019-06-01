# AddPositionToChallengePayments
class AddPositionToChallengePayments < ActiveRecord::Migration[5.2]
  def change
    add_column :challenge_payments, :position, :integer, default: 1
  end
end
