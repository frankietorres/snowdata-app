class Lift < ApplicationRecord
  belongs_to :resort
  has_many :trails
end
