class CreateChallengePayments < ActiveRecord::Migration
  def change
    create_table :challenge_payments do |t|
      t.references :user, index: true
      t.references :challenge, index: true
      t.integer :total_prize_amount
      t.integer :winner_prize_amount

      t.timestamps null: false
    end
    add_foreign_key :challenge_payments, :users
    add_foreign_key :challenge_payments, :challenges
  end
end
