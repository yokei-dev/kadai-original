class Schedule < ApplicationRecord
  belongs_to :trip
  validates :event, presence: true, length: { maximum: 255 }
  
end
