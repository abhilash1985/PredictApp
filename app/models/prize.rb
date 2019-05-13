# Prize
class Prize < ApplicationRecord
  belongs_to :user, optional: true
end
