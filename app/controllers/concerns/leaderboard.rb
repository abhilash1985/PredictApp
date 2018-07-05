# Leaderboard
module Leaderboard
  extend ActiveSupport::Concern

  included do
  end

  def leader_board_data
    @leaderbord = ActiveRecord::Base.connection.select_all(sql_statement)
  end

  def sql_statement
    ActiveRecord::Base.__send__(
      :sanitize_sql,
      [
        "SELECT
            a.user, a.id as user_id,
            SUM(a.total_points) total_points,
            SUM(a.paid_points) AS paid_points,
            COUNT(a.match_id) AS no_of_matches,
            SUM(a.match_points) AS total_match_points,
            ROUND((SUM(a.total_points) * 100 / SUM(a.match_points)),
                    2) AS prediction_percentage,
            COUNT(CASE
                WHEN a.total_points = 0 THEN a.match_id
                ELSE NULL
            END) AS no_of_zero_points
        FROM
            (SELECT
                u.id,
                    CONCAT(u.first_name, ' ', u.last_name) AS user,
                    SUM(p.points) AS total_points,
                    p.points AS points,
                    SUM(CASE
                        WHEN uc.paid = 1 THEN p.points
                        ELSE 0
                    END) AS paid_points,
                    m.id AS match_id,
                    c.id AS challenge,
                    SUM(mq.points) AS match_points
            FROM
                users u
            INNER JOIN user_challenges uc ON uc.user_id = u.id
            INNER JOIN challenges c ON uc.challenge_id = c.id
            INNER JOIN matches m ON m.challenge_id = c.id
            INNER JOIN match_questions mq ON mq.match_id = m.id
            INNER JOIN predictions p ON p.user_challenge_id = uc.id
                AND p.match_question_id = mq.id
            WHERE
                p.points IS NOT NULL
            GROUP BY user , match_id) a
        GROUP BY a.user
        ORDER BY a.user;"
      ], ''
    )
  end

  def leader_board
    leader_board_data
    @leaderbord.sort_by { |x| x['total_points'] }.reverse
  end
end
