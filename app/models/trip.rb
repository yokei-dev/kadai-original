class Trip < ApplicationRecord
  belongs_to :user
  has_many :schedules, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :started_at, presence: true
  validates :finished_at, presence: true
  validate :started_at_earlier_than_finished_at
  validate :not_before_today
  
  
  def started_at_earlier_than_finished_at
    errors.add(:finished_at, '旅行開始日よりも旅行終了日の方を遅くにしてください') if started_at > finished_at
  end
  
  def not_before_today
    errors.add(:started_at, '今日以降の日程を設定してください') if started_at < Date.today
  end
  
end
