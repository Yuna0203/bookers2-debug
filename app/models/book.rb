class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true,
                   length: { maximum: 200}

  #いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索方法分岐機能
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("name LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

end
