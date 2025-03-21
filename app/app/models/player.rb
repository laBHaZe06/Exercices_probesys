class Player < ApplicationRecord
  belongs_to :team
  validates :name, presence: true, length: { maximum: 50 }
  validates :position, presence: true, inclusion: { in: ["Heal", "Tank", "DPS"] }
  validates :team_id, presence: true
  validates :max_number_team, presence: true

  def max_number_team
    if team.players.count >= 11
      errors.add(:team_id, "Team is full sorry")
    end
  end

end
