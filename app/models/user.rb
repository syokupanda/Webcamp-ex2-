class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォロー・フォロワー関係
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :follower_user, through: :follower, source: :followed
  has_many :followed_user, through: :followed, source: :follower
  # フォロー関係 end


  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォロー確認をおこなう
  def following?(user)
    follower_user.include?(user)
  end

  # 検索機能の条件付け
  def self.search_for(target, letter)
    if target == "perfect"
      User.where("name LIKE?", "#{letter}")
    elsif target == "part"
      User.where("name LIKE?", "%#{letter}%")
    elsif target == "front"
      User.where("name LIKE?", "#{letter}%")
    elsif target == "back"
      User.where("name LIKE?", "%#{letter}")
    end
  end

end
