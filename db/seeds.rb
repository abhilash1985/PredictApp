# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Seed the Tournament Type
{ 'cwc2019' => 'cricket' }.each do |key, value|
  tournament_type = TournamentType.where(name: key, game: value)
                                  .first_or_initialize
  tournament_type.save!
end
