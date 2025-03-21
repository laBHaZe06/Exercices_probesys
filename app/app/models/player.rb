class Player < ApplicationRecord
  belongs_to :team
  validates :position, presence: true, inclusion: { in: ["Heal", "Tank", "DPS"] }
end
