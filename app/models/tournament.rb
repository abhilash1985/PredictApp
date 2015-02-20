class Tournament < ActiveRecord::Base
  scope :world_cup, -> { where(name: 'ICC Cricket World Cup 2015') }
  scope :aus_nzl, -> { where(location: 'Australia & New Zealand') }
  scope :active, -> { where('end_date > ?', Date.today) }

  def to_params
  	"#{name}"
  end

end
