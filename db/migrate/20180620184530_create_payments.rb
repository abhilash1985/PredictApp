# CreatePayments
class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.integer :predictions
      t.integer :paid_predictions
      t.integer :amount_paid
      t.integer :matches_won
      t.integer :prize_won
      t.integer :balance
      t.integer :future_predictions

      t.timestamps null: false
    end
    add_foreign_key :payments, :users
  end
end
