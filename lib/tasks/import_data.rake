namespace :import do
  desc "Import master data"
  task master_data: [:tournaments, :stadiums, :teams, :rounds, :players] do
  end

  desc 'Import tournament data'
  task tournaments: :environment do
    tournament = Tournament.world_cup.aus_nzl.first_or_initialize
    tournament.start_date = '14-02-2015'
    tournament.start_date = '29-03-2015'
    tournament.save
    p "Imported Tournaments..."
  end

  desc 'Import stadiums'
  task stadiums: :environment do
    stadiums = %W(Adelaide Hobart Brisbane Auckland Christchurch
                  Canberra Napier Melbourne Nelson Hamilton Sydney
                  Dunedin Perth Wellington)
    stadiums.each do |statdium|
      stadium = Stadium.by_name(statdium).first_or_initialize
      stadium.save
    end
    p "Imported Stadiums..."
  end

  desc 'Import teams'
  task teams: :environment do
    teams = { 'Afghanistan' => 11, 'Australia' => 1, 'Bangladesh' => 9,
              'England' => 5, 'India' => 2, 'Ireland' => 12, 'New Zealand' => 6,
              'Pakistan' => 7, 'Scotland' => 13, 'South Africa' => 3,
              'Sri Lanka' => 4, 'UAE' => 14, 'West Indies' => 8, 'Zimbabwe' => 10}
    teams.each do |team, rank|
      team = Team.by_name(team).first_or_initialize
      team.rank = rank
      team.save
    end
    p "Imported Teams..."
  end

  desc 'Import rounds'
  task rounds: :environment do
    %W(League #{'Quarter Final'} #{'Semi Final'} Final).each do |name|
      round = Round.by_name(name).first_or_initialize
      round.save
    end
    p "Imported Rounds..."
  end

  desc 'Import players'
  task players: :environment do
    # TODO
  end
end