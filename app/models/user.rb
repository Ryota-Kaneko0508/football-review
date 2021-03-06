class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :likes_reviews, through: :likes, source: :review
  
  def like(review)
    likes.find_or_create_by(review_id: review.id)
  end
  
  def unlike(review)
    like = likes.find_by(review_id: review.id)
    like.destroy if like
  end
  
  def like?(review)
    likes_reviews.include?(review)
  end
  
  def feed_reviews
    Review.all
  end
  
end
