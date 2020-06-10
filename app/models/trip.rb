class Trip < ApplicationRecord
  belongs_to :user
  has_many :schedules, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  
  validates :title, presence: true, length: { maximum: 255 }
end
