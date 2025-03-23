class Tournament < ApplicationRecord
    has_many :teams, dependent: :destroy
    has_many :matches, dependent: :destroy

    validates :name, presence: true
    validates :start_date, presence: true, allow_nil: true
    validates :end_date, presence: true,  allow_nil: true
end
