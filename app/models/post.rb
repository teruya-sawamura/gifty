class Post < ApplicationRecord
  mount_uploader :giftpict1, Giftpict1Uploader
  mount_uploader :giftpict2, Giftpict2Uploader
  mount_uploader :giftpict3, Giftpict3Uploader

  
  belongs_to :user
  
  validates :giftwhat, presence: true, length: { maximum:20 }
  validates :giftwho, presence: true, length: { maximum:50 }
  validates :giftwhen, presence: true, length: { maximum:50 }
  validates :givetake,  presence: true, length: { maximum:50 }
  validates :giftcomment, length: { maximum:100 }
  validates :giftpict1, presence: true
  

  # 1:N = post : favorite
  has_many :reverses_of_favorites, class_name: 'Favorite', foreign_key: 'post_id'
  has_many :liked, through: :reverses_of_favorites, source: :user, dependent: :destroy

  def self.search(search)
    keywords = search.split(/[[:blank:]]+/).select(&:present?)
    posts = Post

    keywords.each do |keyword|
      posts = posts.where(['giftwhat LIKE ? OR giftwhen LIKE ? OR giftwho LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    end
    return posts
  end


end
