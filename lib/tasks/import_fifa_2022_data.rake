# frozen_string_literal: true

# bundle exec rails import_fifa2022:master_data
namespace :import_fifa2022 do
  desc 'Import master data'
  task master_data: %i[truncate_data tournaments fifa_stadiums fifa_teams rounds players
                       matches questions match_questions challenges] do
    # for initial run include :questions, :match_questions, :challenges
  end

  desc 'Truncate Old Data'
  task truncate_data: :environment do
    ActiveRecord::Base.connection.execute 'TRUNCATE payments'
    ActiveRecord::Base.connection.execute 'TRUNCATE prizes'

    ActiveRecord::Base.connection.execute 'TRUNCATE predictions'
    ActiveRecord::Base.connection.execute 'TRUNCATE user_challenges'
    ActiveRecord::Base.connection.execute 'TRUNCATE challenge_payments'

    ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
    ActiveRecord::Base.connection.execute 'TRUNCATE matches'
    ActiveRecord::Base.connection.execute 'UPDATE challenge_payments set challenge_id = null where id > 0'
    ActiveRecord::Base.connection.execute 'DELETE FROM challenges where id > 0'
    ActiveRecord::Base.connection.execute 'TRUNCATE players'
    ActiveRecord::Base.connection.execute 'UPDATE users set team_id = null where id > 0'
    ActiveRecord::Base.connection.execute 'DELETE FROM teams'
    ActiveRecord::Base.connection.execute 'TRUNCATE rounds'
    ActiveRecord::Base.connection.execute 'TRUNCATE stadia'
    # ActiveRecord::Base.connection.execute 'TRUNCATE tournaments'
    # ActiveRecord::Base.connection.execute 'TRUNCATE tournament_types'
  end

  desc 'Import tournaments'
  task tournaments: :environment do
    tournament_type = TournamentType.where(name: 'fifa2022', game: 'football')
                                    .first_or_initialize
    tournament_type.save
    tournament = tournament_type.tournaments.fifa2022.first_or_initialize
    tournament.start_date = '20-11-2022'
    tournament.end_date = '18-12-2022'
    tournament.location = 'Qatar'
    tournament.save
    p 'Imported Tournaments...'
  end

  desc 'Import Groups'
  task fifa_stadiums: :environment do
    stadiums = %W(Group\ A Group\ B Group\ C Group\ D Group\ E Group\ F Group\ G Group\ H)
    stadiums.each do |stadium|
      stadium = Stadium.by_name(stadium).first_or_initialize
      stadium.save
    end
    p "Imported Groups..."
  end

  desc 'Import teams'
  task fifa_teams: :environment do
    teams = { 'Brazil' => [1, 'BRA'], 'Belgium' => [2, 'BEL'], 'Argentina' => [3, 'ARG'],
              'France' => [4, 'FRA'], 'England' => [5, 'ENG'], 'Spain' => [7, 'ESP'],
              'Netherlands' => [8, 'NED'], 'Portugal' => [9, 'POR'], 'Denmark' => [10, 'DEN'],
              'Germany' => [11, "GER"], 'Croatia' => [12, 'CRO'], 'Mexico' => [13, 'MEX'],
              'Uruguay' => [14, 'URU'], 'Switzerland' => [15, 'SUI'], 'United States' => [16, 'USA'],
              'Senegal' => [18, 'SEN'], 'Wales' => [19, 'WAL'], 'Iran' => [20, 'IRN'],
              'Serbia' => [21, 'SRB'], 'Morocco' => [22, 'MAR'], 'Japan' => [24, 'JPN'],
              'Poland' => [26, 'POL'], 'Korea Republic' => [28, 'KOR'], 'Tunisia' => [30, 'TUN'],
              'Costa Rica' => [31, 'CRC'], 'Australia' => [38, 'AUS'], 'Canada' => [41, 'CAN'],
              'Cameroon' => [43, 'CMR'], 'Ecuador' => [44, 'ECU'], 'Qatar' => [50, 'QAT'],
              'Saudi Arabia' => [51, 'KSA'], 'Ghana' => [61, 'GHA']
            }
    teams.each do |name, rank|
      team = Team.by_name(name).first_or_initialize
      team.rank = rank[0]
      team.short_name = rank[1]
      p "Team: #{name}(#{rank[1]}) - Rank: #{rank[0]}"
      team.save
    end
    p "Imported Teams..."
  end

  desc 'Import rounds'
  task rounds: :environment do
    %w[GROUP-STAGE PRE-QUARTER QUARTER-FINAL SEMI-FINAL PLAY-OFF FINAL].each do |name|
      round = Round.by_name(name).first_or_initialize
      round.save
      p "Round: #{name}"
    end
    p 'Imported Rounds...'
  end

  desc 'Import players'
  task players: :environment do
    begin
      file = 'db/data/fifa_2022_players.xls'
      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?

          team = Team.by_name(row[0]).first
          next if team.blank?

          player = team.players.by_first_name(row[1].strip.titleize).first_or_initialize
          player.last_name = row[3]&.strip
          player.player_style = row[2]&.strip
          p "Team: #{row[0]}, Player: #{row[1]}, Style: #{row[2]}"
          player.save
        end
      end
      p 'Imported players'
    rescue StandardError => e
      puts "Error while importing #{e} #{e.backtrace}"
    end
  end

  desc 'Import Matches'
  task matches: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE stadia'
    begin
      file = 'db/data/fifa_2022_matches.xls'
      tournament = Tournament.fifa2022.first
      return if tournament.blank?

      Spreadsheet.open(file) do |sheet|
        sheet1 = sheet.worksheet 0
        sheet1.each 1 do |row|
          next if row[0].blank?

          team1 = Team.by_name(row[1].strip).first
          next if team1.blank?

          team2 = Team.by_name(row[2].strip).first
          next if team2.blank?

          match = tournament.matches.by_match_no(row[0])
                            .where(team1_id: team1.id, team2_id: team2.id)
                            .first_or_initialize
          stadium = Stadium.by_name(row[3].strip).first_or_initialize
          stadium.save
          match.stadium_id = stadium.try(:id)
          round = Round.by_name('GROUP-STAGE').first
          match.round_id = round.try(:id)
          match.match_date = row[4].to_time.in_time_zone('Chennai')
          match.save!
          p "#{match.id}: #{row[0]}: #{row[1]} V #{row[2]} at #{row[3]} on #{row[4]}"
        end
      end
      p 'Imported Matches...'
    rescue StandardError => e
      puts "Error while importing #{e} #{e.backtrace}"
    end
  end

  desc 'Import questions'
  task questions: :environment do
    # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
    predict_app = generate_predict_fifa_class.klass_name.new
    questions = predict_app.all_questions
    questions.each do |quest, weightage|
      question = Question.by_question(quest).first_or_initialize
      question.weightage = weightage[0]
      question.save
      p "#{question.id}: Question: #{quest}, Weightage: #{weightage[0]}, Options: #{weightage[1]}"
    end
    p 'Imported Questions...'
  end

  desc 'Import match questions'
  task match_questions: :environment do
    generate_predict_fifa_class
    @predict_class.import_match_questions
    p 'Imported Match Questions...'
  end

  desc 'Import challenges'
  task challenges: :environment do
    generate_predict_fifa_class
    @predict_class.import_challenges
    p 'Imported Challenges...'
  end

  def generate_predict_fifa_class
    tournament = Tournament.fifa2022.first
    tournament_type = TournamentType.fifa2022.first
    @predict_class = PredictClass.new(tournament, tournament_type.name, tournament_type.game)
  end
end
