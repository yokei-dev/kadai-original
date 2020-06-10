class Trip < ApplicationRecord
  belongs_to :user
  has_many :schedules, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
end
