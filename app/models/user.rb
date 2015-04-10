class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :sitcoms
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  def admin?
    role == "admin"
  end

  # def user_vote_by_review(review)
  #   votes.find_by(review: review)
  # end
end
