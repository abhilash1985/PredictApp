# CreatePrizes
class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :prize_type
      t.references :user, index: true
      t.integer :amount

      t.timestamps null: false
    end
    add_foreign_key :prizes, :users
  end
end
