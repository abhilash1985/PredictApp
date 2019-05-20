# AddShortNameToTeam
class AddShortNameToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :short_name, :string
    add_index :teams, :short_name
  end
end
