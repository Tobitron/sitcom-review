class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :sitcom
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :rating, presence: { message: "You must select a rating." },
             numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  validates :user, presence: true
  validates :sitcom, presence: true
  validates_uniqueness_of :user_id, scope: [:sitcom_id], message: "You have already reviewed this show."
  scope :newest_first, -> { order(created_at: :desc) }

  def owner_or_admin?(current_user)
    unless current_user == nil
      user == current_user || current_user.admin?
    end
  end

  def sum_of_votes
    sum = 0
    if votes.empty?
      0
    else
      Vote.where(review_id: id).each do |vote|
        sum += vote.value
      end
    end
    sum
  end

  def user_upvoted?(user)
    if !(user.nil?)
      vote = votes.find_by(user_id: user.id)
      if !(vote.nil?)
        vote.value == 1
      end
    end
  end

  def user_downvoted?(user)
    if !(user.nil?)
      vote = votes.find_by(user_id: user.id)
      if !(vote.nil?)
        vote.value == -1
      end
    end
  end
end
