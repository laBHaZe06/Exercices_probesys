class Team < ApplicationRecord
    belongs_to :tournament, optional: true
    has_many :players

end
