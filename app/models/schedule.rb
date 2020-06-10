class Schedule < ApplicationRecord
  belongs_to :trip
  validates :event, presence: true, length: { maximum: 255 }
  validates :departure_time, presence: true
  validates :arrival_time, presence: true
  validates :price, numericality: {less_than: 10000000}
  
  validate :departure_time_earlier_than_arrival_time
  validate :not_before_today
  
   
  def departure_time_earlier_than_arrival_time
    errors.add(:arrival_time, '出発時間よりも到着時間の方を遅くにしてください') if departure_time && arrival_time &&  departure_time > arrival_time
  end
  
  def not_before_today
    errors.add(:date, '今日以降の日程を設定してください') if date < Date.today
  end
  
  
end
