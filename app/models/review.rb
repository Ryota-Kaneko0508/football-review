class Review < ApplicationRecord
  belongs_to :user
  
  validates :match, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: {maximum: 255 }
end
