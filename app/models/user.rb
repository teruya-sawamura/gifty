class User < ApplicationRecord
  mount_uploader :icon, IconsUploader
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :sex, length: { maximum: 10 }
  validates :introduction, length: { maximum:150 }

  has_secure_password
  
  # 1:N = user : post
  has_many :posts, dependent: :destroy
  
  # 1:N = user : favorite
  has_many :favorites
  has_many :likes, through: :favorites, source: :post
  
  # いいねON
  def liking(post)
    favorites.find_or_create_by(post_id: post.id)
  end
  
  # いいねOFF
  def unliking(post)
    favorite = favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  # いいねしているかどうか
  def liking?(post)
    likes.include?(post)
  end

  
end
