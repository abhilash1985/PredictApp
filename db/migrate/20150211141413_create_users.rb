# CreateUsers
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
