# AddMatchDateToMatch
class AddMatchDateToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :match_date, :datetime
    add_index :matches, :match_date
  end
end
