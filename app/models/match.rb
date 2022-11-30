# frozen_string_literal: true

# Match
class Match < ApplicationRecord
  # Associations
  belongs_to :challenge, optional: true
  belongs_to :stadium
  belongs_to :round, optional: true
  belongs_to :tournament
  belongs_to :team1, class_name: 'Team', foreign_key: :team1_id
  belongs_to :team2, class_name: 'Team', foreign_key: :team2_id
  has_many :match_questions, dependent: :destroy
  has_many :questions, through: :match_questions
  # validations
  validates :match_no, :team1_id, :team2_id, presence: true
  # Scopes
  scope :by_match_no, ->(match_no) { where(match_no: match_no) }
  scope :id_in, ->(match_ids) { where(id: match_ids) }
  scope :no_in, ->(match_no) { where(match_no: match_no) }
  scope :by_challenge, ->(challenge) { where(challenge_id: challenge.id) }
  scope :current_matches, -> { where('match_date >= ?', Date.today.to_time) }
  scope :next_matches, -> { where('match_date >= ?', Time.now) }
  scope :oldest, -> { order(:match_no) }

  def self.by_team(team_id)
    where('team1_id = :team OR team2_id = :team', team: team_id)
  end

  def team1_name
    team1.try(:name)
  end

  def team2_name
    team2.try(:name)
  end

  def team_players(team)
    send(team).players.not_withdrawn.order_by_captain.pluck(:id, :first_name, :player_style)
              .collect { |u| ["#{u[1]} (#{u[2].upcase})", u[0]] }
  end

  def team1_short_name
    team1.try(:short_name)
  end

  def team2_short_name
    team2.try(:short_name)
  end

  def full_name
    "Match #{match_no} : #{team1_short_name} VS #{team2_short_name}"
  end

  def full_name_with_date
    "#{full_name} - #{match_date.to_s(:default_with_time)}"
  end

  def full_name_with_points
    "#{full_name} : #{total_points}(pts)"
  end

  def stadium_name
    stadium.try(:name)
  end

  def total_points
    match_questions.sum(:points)
  end

  def started?
    match_date <= Time.zone.now
  end

  def group_stage?
    round_name == 'GROUP-STAGE'
  end

  def round_name
    round&.name
  end

  # Creating match questions based on question
  def create_match_question(question, selected_questions = {})
    match_question = match_questions.by_question(question).first_or_initialize
    options = selected_questions.fetch(question.question, [])[1]
    raise 'Invalid options' if options.nil?

    match_question.options = { v: options }
    match_question.points = question.weightage
    match_question.save
    p "#{match_question.id} - Match: #{match_no}, Q: #{question.question}, Options: #{options}"
  end

  def update_or_create_match_questions(params)
    if match_questions.blank?
      new_match_questions(params)
    else
      update_match_questions(params)
    end
  end

  def update_match_questions(params)
    match_questions.each do |match_question|
      match_question_params = params[match_question.id.to_s]
      options = convert_options_array(match_question_params)
      match_question.update(question_id: match_question_params[:question_id], options: options)
    end
  end

  def new_match_questions(params)
    params.keys.sort.each do |key|
      match_question_params = params[key]
      options = convert_options_array(match_question_params)
      match_question = match_questions.new
      match_question.question_id = match_question_params[:question_id]
      match_question.options = options
      match_question.save
    end
  end

  # Predicting match for user - After Challenge ends, only for Admin
  def predict_match_for_user(user, params)
    user_challenge = user.user_challenges.by_challenge(params[:challenge_id]).first_or_initialize
    if user.point_booster_available? || params[:point_booster].blank?
      user_challenge.point_booster = params[:point_booster]
    end
    user_challenge.save
    create_match_questions_for_user(params[:match_question], user_challenge)
  end

  rails_admin do
    # list do
    # field :team1_short_name
    # field :team2_short_name
    # field :created_at
    # end
  end

  private

  def convert_options_array(params)
    { v: [params[:option1], params[:option2], params[:option3], params[:option4], params[:option5],
          params[:option6], params[:option7], params[:option8], params[:option9], params[:option10]]
      .reject(&:blank?) }
  end

  def create_match_questions_for_user(match_questions, user_challenge)
    match_questions.each do |key, value|
      prediction = user_challenge.predictions.by_match_question(key).first_or_initialize
      prediction.user_answer = value
      prediction.save
    end
  end
end
