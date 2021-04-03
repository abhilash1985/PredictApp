# namespace :import_cwc2019 do
#   desc 'Import master data'
#   task master_data: [:tournaments, :stadiums, :teams, :rounds, :players,
#                      :matches, :questions, :match_questions, :challenges] do
#     # for initial run include :questions, :match_questions, :challenges
#   end

#   desc 'Import tournaments'
#   task tournaments: :environment do
#     tournament_type = TournamentType.cwc2019.first
#     tournament = tournament_type.tournaments.cricket_2019.first_or_initialize
#     tournament.start_date = '30-05-2019'
#     tournament.end_date = '14-07-2019'
#     tournament.location = 'England & Wales'
#     tournament.save
#     p 'Imported Tournaments...'
#   end

#   desc 'Import stadiums'
#   task stadiums: :environment do
#     stadiums = %w(Lords Leeds)
#     stadiums.each do |stadium|
#       stadium = Stadium.by_name(stadium).first_or_initialize
#       stadium.save
#     end
#     p 'Imported Stadiums...'
#   end

#   desc 'Import teams'
#   task teams: :environment do
#     teams = { 'Afghanistan' => [10, 'AFG'], 'Australia' => [5, 'AUS'], 'Bangladesh' => [7, 'BAN'],
#               'England' => [1, 'ENG'], 'India' => [2, 'IND'], 'New Zealand' => [4, 'NZ'],
#               'Pakistan' => [6, 'PAK'], 'South Africa' => [3, 'SA'],
#               'Sri Lanka' => [9, 'SL'], 'West Indies' => [8, 'WI'] }
#     teams.each do |name, rank|
#       team = Team.by_name(name).first_or_initialize
#       team.rank = rank[0]
#       team.short_name = rank[1]
#       p "Team: #{name}(#{rank[1]}) - Rank: #{rank[0]}"
#       team.save
#     end
#     p 'Imported Teams...'
#   end

#   desc 'Import rounds'
#   task rounds: :environment do
#     %w(GROUP-STAGE SEMI-FINAL FINAL).each do |name|
#       round = Round.by_name(name).first_or_initialize
#       round.save
#       p "Round: #{name}"
#     end
#     p 'Imported Rounds...'
#   end

#   desc 'Import players'
#   task players: :environment do
#     begin
#       file = 'db/data/players.xls'
#       Spreadsheet.open(file) do |sheet|
#         sheet1 = sheet.worksheet 0
#         sheet1.each 1 do |row|
#           next if row[0].blank?
#           team = Team.by_name(row[0]).first
#           next if team.blank?
#           player = team.players.by_first_name(row[1].strip).first_or_initialize
#           player.player_style = row[2].strip
#           p "Team: #{row[0]}, Player: #{row[1]}, Style: #{row[2]}"
#           player.save
#         end
#       end
#       p 'Imported players'
#     rescue => e
#       puts "Error while importing #{e} #{e.backtrace}"
#     end
#   end

#   desc 'Import Matches'
#   task matches: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE matches'
#     # ActiveRecord::Base.connection.execute 'TRUNCATE stadia'
#     begin
#       file = 'db/data/matches.xls'
#       tournament = Tournament.cricket_2019.first
#       return if tournament.blank?
#       Spreadsheet.open(file) do |sheet|
#         sheet1 = sheet.worksheet 0
#         sheet1.each 1 do |row|
#           next if row[0].blank?
#           team1 = Team.by_name(row[1].strip).first
#           next if team1.blank?
#           team2 = Team.by_name(row[2].strip).first
#           next if team2.blank?
#           match = tournament.matches.by_match_no(row[0])
#                             .where(team1_id: team1.id, team2_id: team2.id)
#                             .first_or_initialize
#           stadium = Stadium.by_name(row[3].strip).first_or_initialize
#           stadium.save
#           match.stadium_id = stadium.try(:id)
#           round = Round.by_name('GROUP-STAGE').first
#           match.round_id = round.try(:id)
#           match.match_date = row[4].to_time
#           match.save!
#           p "#{match.id}: #{row[0]}: #{row[1]} V #{row[2]} at #{row[3]} on #{row[4]}"
#         end
#       end
#       p 'Imported Matches...'
#     rescue => e
#       puts "Error while importing #{e} #{e.backtrace}"
#     end
#   end

#   desc 'Import questions'
#   task questions: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
#     predict_app = generate_predict_class.klass_name.new
#     questions = predict_app.all_questions
#     questions.each do |quest, weightage|
#       question = Question.by_question(quest).first_or_initialize
#       question.weightage = weightage[0]
#       question.save
#       p "#{question.id}: Question: #{quest}, Weightage: #{weightage[0]}, Options: #{weightage[1]}"
#     end
#     p 'Imported Questions...'
#   end

#   desc 'Import match questions'
#   task match_questions: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
#     generate_predict_class
#     @predict_class.import_match_questions
#     p 'Imported Match Questions...'
#   end

#   desc 'Import challenges'
#   task challenges: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE challenges'
#     generate_predict_class
#     @predict_class.import_challenges
#     p 'Imported Challenges...'
#   end

#   desc 'Import Bonus questions'
#   task bonus_questions: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
#     predict_app = generate_predict_class.klass_name.new
#     questions = predict_app.all_bonus_questions
#     questions.each do |quest, weightage|
#       question = Question.by_question(quest).first_or_initialize
#       question.weightage = weightage[0]
#       question.save
#       p "#{question.id}: Bonus Question: #{quest}, Weightage: #{weightage[0]}, Options: #{weightage[1]}"
#     end
#     p 'Imported Bonus Questions...'
#   end

#   desc 'Import Bonus match questions'
#   task bonus_match_questions: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE match_questions'
#     predict_app = generate_predict_class.klass_name.new
#     predict_app.import_bonus_match_questions
#     p 'Imported Bonus Match Questions...'
#   end

#   desc 'Import SEMI-FINAL Matches'
#   task semi_matches: :environment do
#     begin
#       semi_matches =
#         [[46, 'India', 'New Zealand', 'Old Trafford', '09-07-2019 15:00:00'],
#          [47, 'England', 'Australia', 'Edgbaston', '11-07-2019 15:00:00']]
#       tournament = Tournament.cricket_2019.first
#       return if tournament.blank?
#       semi_matches.each do |row|
#         next if row[0].blank?
#         team1 = Team.by_name(row[1].strip).first
#         next if team1.blank?
#         team2 = Team.by_name(row[2].strip).first
#         next if team2.blank?
#         match = tournament.matches.by_match_no(row[0])
#                           .where(team1_id: team1.id, team2_id: team2.id)
#                           .first_or_initialize
#         stadium = Stadium.by_name(row[3].strip).first_or_initialize
#         stadium.save
#         match.stadium_id = stadium.try(:id)
#         round = Round.by_name('SEMI-FINAL').first
#         match.round_id = round.try(:id)
#         match.match_date = row[4]
#         match.save!
#         p "#{match.id}: #{row[0]}: #{row[1]} V #{row[2]} at #{row[3]} on #{row[4]}"
#       end
#       p 'Imported SEMI-FINAL Matches...'
#     rescue => e
#       puts "Error while importing #{e} #{e.backtrace}"
#     end
#   end

#   desc 'Import SEMI-FINAL questions'
#   task semi_questions: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
#     predict_app = generate_predict_class.klass_name.new
#     questions = predict_app.all_semi_questions
#     questions.each do |quest, weightage|
#       question = Question.by_question(quest).first_or_initialize
#       question.weightage = weightage[0]
#       sleep(1)
#       question.updated_at = Time.now
#       question.save
#       p "#{question.id}: SEMI-FINAL Question: #{quest}, Weightage: #{weightage[0]}, Options: #{weightage[1]}"
#     end
#     p 'Imported SEMI-FINAL Questions...'
#   end

#   desc 'Import SEMI-FINAL match questions'
#   task semi_match_questions: :environment do
#     generate_predict_class
#     @predict_class.import_semi_match_questions
#     p 'Imported SEMI-FINAL Match Questions...'
#   end

#   desc 'Import FINAL questions'
#   task final_questions: :environment do
#     # ActiveRecord::Base.connection.execute 'TRUNCATE questions'
#     predict_app = generate_predict_class.klass_name.new
#     questions = predict_app.final_questions
#     questions.each do |quest, weightage|
#       question = Question.by_question(quest).first_or_initialize
#       question.weightage = weightage[0]
#       sleep(1)
#       question.updated_at = Time.now
#       question.save
#       p "#{question.id}: FINAL Question: #{quest}, Weightage: #{weightage[0]}, Options: #{weightage[1]}"
#     end
#     p 'Imported FINAL Questions...'
#   end

#   desc 'Import FINAL match questions'
#   task final_match_questions: :environment do
#     generate_predict_class
#     @predict_class.import_final_match_questions
#     p 'Imported FINAL Match Questions...'
#   end

#   def generate_predict_class
#     tournament = Tournament.cricket_2019.first
#     tournament_type = TournamentType.cwc2019.first
#     @predict_class = PredictClass.new(tournament, tournament_type.name, tournament_type.game)
#   end
# end
