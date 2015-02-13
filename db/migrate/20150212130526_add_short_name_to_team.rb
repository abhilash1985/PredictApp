class AddShortNameToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :short_name, :string
    add_index :teams, :short_name
  end
end
