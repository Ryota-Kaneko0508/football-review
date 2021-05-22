class Review < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
  
  validates :match, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: {maximum: 255 }
end
