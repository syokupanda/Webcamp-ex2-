class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	# 検索機能の条件付け
  def self.search_for(target, letter)
    if target == "perfect"
      Book.where("title LIKE?", "#{letter}")
    elsif target == "part"
      Book.where("title LIKE?", "%#{letter}%")
    elsif target == "front"
      Book.where("title LIKE?", "#{letter}%")
    elsif target == "back"
      Book.where("title LIKE?", "%#{letter}")
    end
  end

end
